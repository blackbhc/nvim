return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
      enabled = false,
    },
    -- add any global capabilities here
    capabilities = {},
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
          "--offset-encoding=utf-16",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig/util").root_pattern(".git"),
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
      racket_langserver = {
        mason = false, -- set to false if you don't want this server to be installed with mason
        cmd = { "racket", "--lib", "racket-langserver" },
        filetypes = { "racket", "scheme" },
        root_dir = require("lspconfig/util").root_pattern(".git"),
        single_file_support = true,
      },
      rust_analyzer = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_dir = require("lspconfig/util").root_pattern("Cargo.toml", "rust-project.json"),
        capabilities = {
          experimental = {
            serverStatusNotification = true,
          },
          general = {
            positionEncodings = { "utf-16" },
          },
          textDocument = {
            callHierarchy = {
              dynamicRegistration = false,
            },
            codeAction = {
              codeActionLiteralSupport = {
                codeActionKind = {
                  valueSet = {
                    "",
                    "quickfix",
                    "refactor",
                    "refactor.extract",
                    "refactor.inline",
                    "refactor.rewrite",
                    "source",
                    "source.organizeImports",
                  },
                },
              },
              dataSupport = true,
              dynamicRegistration = true,
              isPreferredSupport = true,
              resolveSupport = {
                properties = { "edit" },
              },
            },
            completion = {
              completionItem = {
                commitCharactersSupport = false,
                deprecatedSupport = false,
                documentationFormat = { "markdown", "plaintext" },
                preselectSupport = false,
                snippetSupport = false,
              },
              completionItemKind = {
                valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
              },
              contextSupport = false,
              dynamicRegistration = false,
            },
            declaration = {
              linkSupport = true,
            },
            definition = {
              dynamicRegistration = true,
              linkSupport = true,
            },
            diagnostic = {
              dynamicRegistration = false,
            },
            documentHighlight = {
              dynamicRegistration = false,
            },
            documentSymbol = {
              dynamicRegistration = false,
              hierarchicalDocumentSymbolSupport = true,
              symbolKind = {
                valueSet = {
                  1,
                  2,
                  3,
                  4,
                  5,
                  6,
                  7,
                  8,
                  9,
                  10,
                  11,
                  12,
                  13,
                  14,
                  15,
                  16,
                  17,
                  18,
                  19,
                  20,
                  21,
                  22,
                  23,
                  24,
                  25,
                  26,
                },
              },
            },
            formatting = {
              dynamicRegistration = true,
            },
            hover = {
              contentFormat = { "markdown", "plaintext" },
              dynamicRegistration = true,
            },
            implementation = {
              linkSupport = true,
            },
            inlayHint = {
              dynamicRegistration = true,
              resolveSupport = {
                properties = {},
              },
            },
            publishDiagnostics = {
              dataSupport = true,
              relatedInformation = true,
              tagSupport = {
                valueSet = { 1, 2 },
              },
            },
            rangeFormatting = {
              dynamicRegistration = true,
            },
            references = {
              dynamicRegistration = false,
            },
            rename = {
              dynamicRegistration = true,
              prepareSupport = true,
            },
            semanticTokens = {
              augmentsSyntaxTokens = true,
              dynamicRegistration = false,
              formats = { "relative" },
              multilineTokenSupport = false,
              overlappingTokenSupport = true,
              requests = {
                full = {
                  delta = true,
                },
                range = false,
              },
              serverCancelSupport = false,
              tokenModifiers = {
                "declaration",
                "definition",
                "readonly",
                "static",
                "deprecated",
                "abstract",
                "async",
                "modification",
                "documentation",
                "defaultLibrary",
              },
              tokenTypes = {
                "namespace",
                "type",
                "class",
                "enum",
                "interface",
                "struct",
                "typeParameter",
                "parameter",
                "variable",
                "property",
                "enumMember",
                "event",
                "function",
                "method",
                "macro",
                "keyword",
                "modifier",
                "comment",
                "string",
                "number",
                "regexp",
                "operator",
                "decorator",
              },
            },
            signatureHelp = {
              dynamicRegistration = false,
              signatureInformation = {
                activeParameterSupport = true,
                documentationFormat = { "markdown", "plaintext" },
                parameterInformation = {
                  labelOffsetSupport = true,
                },
              },
            },
            synchronization = {
              didSave = true,
              dynamicRegistration = false,
              willSave = true,
              willSaveWaitUntil = true,
            },
            typeDefinition = {
              linkSupport = true,
            },
          },
          window = {
            showDocument = {
              support = true,
            },
            showMessage = {
              messageActionItem = {
                additionalPropertiesSupport = false,
              },
            },
            workDoneProgress = true,
          },
          workspace = {
            applyEdit = true,
            configuration = true,
            didChangeWatchedFiles = {
              dynamicRegistration = true,
              relativePatternSupport = true,
            },
            inlayHint = {
              refreshSupport = true,
            },
            semanticTokens = {
              refreshSupport = true,
            },
            symbol = {
              dynamicRegistration = false,
              symbolKind = {
                valueSet = {
                  1,
                  2,
                  3,
                  4,
                  5,
                  6,
                  7,
                  8,
                  9,
                  10,
                  11,
                  12,
                  13,
                  14,
                  15,
                  16,
                  17,
                  18,
                  19,
                  20,
                  21,
                  22,
                  23,
                  24,
                  25,
                  26,
                },
              },
            },
            workspaceEdit = {
              resourceOperations = { "rename", "create", "delete" },
            },
            workspaceFolders = true,
          },
        },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
            checkOnSave = {
              command = "clippy",
            },
            diagnostics = {
              enableExperimental = true,
            },
            inlayHints = {
              chainingHints = true,
              parameterHints = true,
              typeHints = true,
              maxLength = 60,
            },
            rustfmt = {
              extraArgs = { "+nightly" },
            },
          },
        },
      },

      -- python language server, with black as the default formatter
      pyright = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = require("lspconfig/util").root_pattern(".git", "setup.py"),
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "off",
              stubPath = vim.fn.stdpath("data") .. "/stubs",
              stubs = {
                "numpy-stubs",
                "pandas-stubs",
                "scipy-stubs",
                "matplotlib-stubs",
                "sympy-stubs",
                "galpy-stubs",
                "astropy-stubs",
                "sklearn-stubs",
                "torch-stubs",
                "torchvision-stubs",
                "tensorflow-stubs",
                "tensorflow-addons-stubs",
                "jax-stubs",
                "jaxlib-stubs",
                "optax-stubs",
                "dm-haiku-stubs",
                "dm-tree-stubs",
                "dm-env-stubs",
                "dm-control-stubs",
                "dm-acme-stubs",
                "dm-reverb-stubs",
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
        root_dir = require("lspconfig/util").root_pattern(".fortls"),
      },
      -- bash language server, with many features open
      bashls = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "zsh", "bash" },
        root_dir = require("lspconfig/util").root_pattern(".git"),
        settings = {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
          },
        },
      },
      -- cmake language server, with many features open
      cmake = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = require("lspconfig/util").root_pattern(
          "CMakePresets.json",
          "CTestConfig.cmake",
          ".git",
          "build",
          "cmake"
        ),
      },
      marksman = {
        mason = true, -- set to false if you don't want this server to be installed with mason
        cmd = { "marksman", "server" },
        filetypes = { "markdown", "markdown.mdx" },
        root_dir = require("lspconfig/util").root_pattern(".git", ".marksman.toml"),
        single_file_support = true,
      },
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
    },
  },
  ---@param opts PluginLspOpts
  config = function(_, opts)
    local Util = require("lazyvim.util")
    if Util.has("neoconf.nvim") then
      local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
      require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
    end

    -- setup autoformat
    Util.format.register(Util.lsp.formatter())

    -- deprectaed options
    if opts.autoformat ~= nil then
      vim.g.autoformat = opts.autoformat
      Util.deprecate("nvim-lspconfig.opts.autoformat", "vim.g.autoformat")
    end

    -- setup keymaps
    Util.lsp.on_attach(function(client, buffer)
      require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    local register_capability = vim.lsp.handlers["client/registerCapability"]

    vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
      local ret = register_capability(err, res, ctx)
      local client_id = ctx.client_id
      ---@type lsp.Client
      local client = vim.lsp.get_client_by_id(client_id)
      local buffer = vim.api.nvim_get_current_buf()
      require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      return ret
    end

    -- diagnostics
    for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end

    local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

    if opts.inlay_hints.enabled and inlay_hint then
      Util.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/inlayHint") then
          inlay_hint(buffer, true)
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
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
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

    -- get all the servers that are available through mason-lspconfig
    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    end

    local ensure_installed = {} ---@type string[]
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

    if Util.lsp.get_config("denols") and Util.lsp.get_config("tsserver") then
      local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      Util.lsp.disable("tsserver", is_deno)
      Util.lsp.disable("denols", function(root_dir)
        return not is_deno(root_dir)
      end)
    end
  end,
}
