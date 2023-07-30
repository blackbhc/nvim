return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = function()
        return require("lazyvim.util").has("nvim-cmp")
      end,
    },
  },
  ---@class PluginLspOpts
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
    },
    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = true,
    },
    -- add any global capabilities here
    capabilities = {},
    -- Automatically format on save
    autoformat = true,
    -- Enable this to show formatters used in a notification
    -- Useful for debugging formatter issues
    format_notify = false,
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      jsonls = {},
      lua_ls = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      -- c++ language server, with clangd as the default and with many features open, especially for inlay hints
      clangd = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=bundled",
          "--header-insertion=iwyu",
          "--suggest-missing-includes",
          "--cross-file-rename",
          "--clang-tidy-checks=-*,bugprone-*,cert-*,clang-analyzer-*,cppcoreguidelines-*,google-*,llvm-*,misc-*,modernize-*,performance-*,portability-*,readability-*",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig/util").root_pattern(".git", "setup.py"),
        settings = {
          -- clangd setup
          clangd = {
            -- InlayHints:
            -- Designators: Yes
            -- Enabled: Yes
            -- ParameterNames: Yes
            -- DeducedTypes: Yes
            inlay_hints = {
              parameterNames = true,
              parameterTypes = true,
              typeHints = true,
              other = true,
            },
          },
        },
      },
      -- python language server, with black as the default formatter
      pylsp = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "pylsp" },
        filetypes = { "python" },
        root_dir = require("lspconfig/util").root_pattern(".git", "setup.py"),
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                enabled = false,
              },
              pydocstyle = {
                enabled = false,
              },
              pylint = {
                enabled = false,
              },
              flake8 = {
                enabled = false,
              },
              jedi_completion = {
                enabled = true,
              },
              jedi_hover = {
                enabled = true,
              },
              jedi_references = {
                enabled = true,
              },
              jedi_signature_help = {
                enabled = true,
              },
              jedi_symbols = {
                enabled = true,
              },
              mccabe = {
                enabled = false,
              },
              preload = {
                enabled = false,
              },
              pyflakes = {
                enabled = false,
              },
              rope_completion = {
                enabled = true,
              },
              yapf = {
                enabled = true,
              },
            },
          },
        },
      },

      -- fortran language server, with many features open
      fortls = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "fortls" },
        filetypes = { "fortran" },
        root_dir = require("lspconfig/util").root_pattern(".git", "setup.py"),
      },
      -- bash language server, with many features open
      bashls = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "zsh" },
        root_dir = require("lspconfig/util").root_pattern(".git", "setup.py"),
      },
      -- cmake language server, with many features open
      cmake = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = require("lspconfig/util").root_pattern(".git", "setup.py"),
      },
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
      end,
    },
  },
  ---@param opts PluginLspOpts
  config = function(_, opts)
    local Util = require("lazyvim.util")
    -- setup autoformat
    require("lazyvim.plugins.lsp.format").setup(opts)
    -- setup formatting and keymaps
    Util.on_attach(function(client, buffer)
      require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    -- diagnostics
    for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end

    if opts.inlay_hints.enabled and vim.lsp.buf.inlay_hint then
      Util.on_attach(function(client, buffer)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.buf.inlay_hint(buffer, true)
        end
      end)
    end

    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function(diagnostic)
          local icons = require("lazyvim.config").icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local servers = opts.servers
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities(),
      opts.capabilities or {}
    )

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    -- get all the servers that are available thourgh mason-lspconfig
    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    end

    local ensure_installed = { clangd, pyright } ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    if have_mason then
      mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    end

    if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
      local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      Util.lsp_disable("tsserver", is_deno)
      Util.lsp_disable("denols", function(root_dir)
        return not is_deno(root_dir)
      end)
    end
  end,
}
