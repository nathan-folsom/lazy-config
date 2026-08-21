-- Java support for the rhombus repos (~/rhombus/*).
--
-- Two different JVMs are in play:
--   * jdtls itself needs JDK 21+ (homebrew keg-only openjdk@21).
--   * The Gradle daemon needs a JDK its build accepts -- most repos pin Gradle 7.6
--     and target 17, but repos on the Gradle 9 wrapper need a newer JDK.
local JDTLS_JDK = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
local DEFAULT_JDK = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

-- Discover installed JDKs as { major = path }, newest wins per major version.
local function installed_jdks()
  local jdks = {}
  local candidates = vim.fn.glob("/Library/Java/JavaVirtualMachines/*/Contents/Home", false, true)
  vim.list_extend(candidates, vim.fn.glob("/opt/homebrew/opt/openjdk*/libexec/openjdk.jdk/Contents/Home", false, true))
  for _, home in ipairs(candidates) do
    local release = io.open(home .. "/release")
    if release then
      local contents = release:read("*a")
      release:close()
      local version = contents:match('JAVA_VERSION="(%d+)')
      if version then
        jdks[tonumber(version)] = home
      end
    end
  end
  return jdks
end

-- Most rhombus repos have no gradle wrapper and need the pinned 7.x install
-- (homebrew symlink -> ~/.sandbox/tools/gradle-x.y.z), not jdtls' bundled Gradle.
local function gradle_home()
  local exe = vim.fn.exepath("gradle")
  if exe == "" then
    return nil
  end
  return vim.fn.fnamemodify(vim.uv.fs_realpath(exe) or exe, ":h:h")
end

-- Gradle major version from a repo's wrapper, if it has one.
local function wrapper_gradle_major(root_dir)
  local f = io.open(root_dir .. "/gradle/wrapper/gradle-wrapper.properties")
  if not f then
    return nil
  end
  local contents = f:read("*a")
  f:close()
  return tonumber(contents:match("gradle%-(%d+)%.[%d.]*%-?%a*%.zip"))
end

-- Which JDK should run the Gradle daemon for this repo?
local function gradle_jdk(root_dir)
  local jdks = installed_jdks()
  local major = root_dir and wrapper_gradle_major(root_dir)
  -- Gradle 7.x refuses JDK 20+; Gradle 9 builds here need the newest JDK around.
  if major and major >= 9 then
    local newest = 0
    for version, _ in pairs(jdks) do
      newest = math.max(newest, version)
    end
    if newest > 0 then
      return jdks[newest]
    end
  end
  return jdks[17] or DEFAULT_JDK
end

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- These repos nest settings.gradle in subprojects (api/, service/), so the
      -- nearest build file is the wrong root -- use the repo root instead.
      opts.root_dir = function(fname)
        local git_root = vim.fs.root(fname, { ".git" })
        if git_root then
          for _, marker in ipairs({ "settings.gradle", "settings.gradle.kts", "build.gradle", "pom.xml" }) do
            if vim.uv.fs_stat(git_root .. "/" .. marker) then
              return git_root
            end
          end
        end
        return vim.fs.root(fname, vim.lsp.config.jdtls.root_markers)
      end

      -- Big projects: give the language server room, and run it on JDK 21.
      vim.list_extend(opts.cmd, {
        "--java-executable=" .. JDTLS_JDK .. "/bin/java",
        "--jvm-arg=-Xmx4g",
        "--jvm-arg=-XX:+UseG1GC",
        "--jvm-arg=-XX:GCTimeRatio=4",
        "--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
      })

      local runtimes = {}
      for version, home in pairs(installed_jdks()) do
        table.insert(runtimes, { name = "JavaSE-" .. version, path = home, default = version == 17 })
      end

      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          configuration = {
            -- Projects target 17; jdtls resolves this from the execution environment.
            runtimes = runtimes,
            updateBuildConfiguration = "interactive",
          },
          import = {
            gradle = {
              enabled = true,
              -- Used when the repo ships a gradlew; otherwise `home` applies.
              wrapper = { enabled = true },
              home = gradle_home(),
            },
            maven = { enabled = true },
          },
          eclipse = { downloadSources = true },
          maven = { downloadSources = true },
          references = { includeDecompiledSources = true },
          signatureHelp = { enabled = true },
          -- Scanning every jar in these repos makes completion crawl.
          maxConcurrentBuilds = 2,
        },
      })

      -- The Gradle JDK depends on the repo, and jdtls reads its Gradle preferences
      -- at startup -- before didChangeConfiguration arrives -- so they have to go
      -- through initializationOptions.
      opts.jdtls = function(config)
        local settings = vim.deepcopy(opts.settings)
        settings.java.import.gradle.java = { home = gradle_jdk(config.root_dir) }
        config.settings = settings
        config.init_options = vim.tbl_deep_extend("force", config.init_options or {}, { settings = settings })
        return config
      end

      return opts
    end,
  },
}
