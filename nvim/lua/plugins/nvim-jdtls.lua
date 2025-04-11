java_filetypes = { "java" }

-- https://www.lazyvim.org/extras/lang/java
return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	ft = java_filetypes,
	opts = function()
		return {
			-- How to find the root dir for a given filename. The default comes from
			-- lspconfig which provides a function specifically for java projects.
			-- root_dir = LazyVim.lsp.get_raw_config("jdtls").default_config.root_dir,
			root_dir = function()
                return vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
				-- return vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })
			end,

			-- How to find the project name for a given root dir.
			project_name = function(root_dir)
				return root_dir and vim.fs.basename(root_dir)
			end,

			-- Where are the config and workspace dirs for a project?
			jdtls_config_dir = function(project_name)
				return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
			end,
			jdtls_workspace_dir = function(project_name)
				return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
			end,

			-- How to run jdtls. This can be overridden to a full java command-line
			-- if the Python wrapper script doesn't suffice.
			cmd = {
				vim.fn.exepath("jdtls"),
			},
			full_cmd = function(opts)
				local fname = vim.api.nvim_buf_get_name(0)
				local root_dir = opts.root_dir(fname)
				local project_name = opts.project_name(root_dir)
				local cmd = vim.deepcopy(opts.cmd)
				if project_name then
					vim.list_extend(cmd, {
						"-configuration",
						opts.jdtls_config_dir(project_name),
						"-data",
						opts.jdtls_workspace_dir(project_name),
					})
				end
				return cmd
			end,

			-- These depend on nvim-dap, but can additionally be disabled by setting false here.
			dap = {
                hotcodereplace = "auto",
                config_overrides = {
                    filters = {
                        static = true,
                        synthetic = true,
                        names = { "this", "$$_hibernate_*", "handler", "interceptor" },
                    }
                },
            },
			dap_main = {},
			test = true,
			settings = {
				java = {
					inlayHints = {
						parameterNames = {
							enabled = "all",
						},
					},
					configuration = {
						updateBuildConfiguration = "automatic",
					},
					maven = {
						downloadSources = true,
					},
					autobuild = {
						enabled = true,
					},
					import = {
						maven = {
							enabled = true,
						},
					},
				},
			},
		}
	end,
	config = function(_, opts)
		-- Find the extra bundles that should be passed on the jdtls command-line
		-- if nvim-dap is enabled with java debug/test.
		local dap_installed = true
		local mason_registry = require("mason-registry")
		local bundles = {} ---@type string[]
		if mason_registry then
			if opts.dap and dap_installed and mason_registry.is_installed("java-debug-adapter") then
				local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
				local java_dbg_path = java_dbg_pkg:get_install_path()
				local jar_patterns = {
					java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
				}
				-- java-test also depends on java-debug-adapter.
				if opts.test and mason_registry.is_installed("java-test") then
					local java_test_pkg = mason_registry.get_package("java-test")
					local java_test_path = java_test_pkg:get_install_path()
					vim.list_extend(jar_patterns, {
						java_test_path .. "/extension/server/*.jar",
					})
				end
				for _, jar_pattern in ipairs(jar_patterns) do
					for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
						table.insert(bundles, bundle)
					end
				end
			end
		end

		local function attach_jdtls()
			local fname = vim.api.nvim_buf_get_name(0)

			-- Configuration can be augmented and overridden by opts.jdtls
			local config = {
				cmd = opts.full_cmd(opts),
				root_dir = opts.root_dir(fname),
				init_options = {
					bundles = bundles,
				},
				settings = opts.settings,
				-- enable CMP capabilities
				capabilities = require("cmp_nvim_lsp").default_capabilities() or nil,
			}

			-- Existing server will be reused if the root_dir matches.
			require("jdtls").start_or_attach(config)
			-- not need to require("jdtls.setup").add_commands(), start automatically adds commands
            vim.keymap.set("n", "<Leader>jtc", require("jdtls").test_class)
            vim.keymap.set("n", "<Leader>jtm", require("jdtls").test_nearest_method)
			-- Organize imports
			vim.keymap.set("n", "<Leader>oi", function()
				require("jdtls").organize_imports()
			end, { desc = "Organize imports" })

			-- Extract variable (normal mode)
			vim.keymap.set("n", "<Leader>ev", function()
				require("jdtls").extract_variable()
			end, { desc = "Extract variable" })

			-- Extract variable (visual mode)
			vim.keymap.set("v", "<Leader>ev", function()
				require("jdtls").extract_variable(true)
			end, { desc = "Extract variable with selection" })

			-- Extract constant (normal mode)
			vim.keymap.set("n", "<Leader>ec", function()
				require("jdtls").extract_constant()
			end, { desc = "Extract constant" })

			-- Extract constant (visual mode)
			vim.keymap.set("v", "<Leader>ec", function()
				require("jdtls").extract_constant(true)
			end, { desc = "Extract constant with selection" })

			-- Extract method (visual mode)
			vim.keymap.set("v", "<Leader>em", function()
				require("jdtls").extract_method(true)
			end, { desc = "Extract method with selection" })
		end

		-- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
		-- depending on filetype, so this autocmd doesn't run for the first file.
		-- For that, we call directly below.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = java_filetypes,
			callback = attach_jdtls,
		})

		-- Avoid race condition by calling attach the first time, since the autocmd won't fire.
		attach_jdtls()
	end,
}
