if vim.g.obsidian then
  return
end

local set = vim.keymap.set

local extend = function(name, key, values)
  local mod = require("lspconfig.configs")[name]
  if not mod or not mod.default_config then
    return values
  end

  local default = mod.default_config
  local keys = vim.split(key, '.', { plain = true })
  while #keys > 0 do
    local item = table.remove(keys, 1)
    default = default[item]
    if not default then
      return values
    end
  end

  if vim.islist(default) then
    for _, value in ipairs(default) do
      table.insert(values, value)
    end
  elseif type(default) == "table" then
    for item, value in pairs(default) do
      if not vim.tbl_contains(values, item) then
        values[item] = value
      end
    end
  end
  return values
end

-- capabilities (completion, snippets, etc.)
local capabilities
if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').default_capabilities()
end

-- your servers
local servers = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        imports = { granularity = { group = "module" }, prefix = "self" },
        cargo = { buildScripts = { enable = true } },
        procMacro = { enable = true },
        diagnostics = { enable = true },
      }
    }
  },
  zls = {},
  html = {},
  ts_ls = {},
  csharp_ls = {
    cmd = { "csharp-ls" },
    filetypes = { "cs" },
    init_options = { AutomaticWorkspaceInit = true },
  },
  texlab = {
    settings = {
      texlab = {
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = false,
        },
        chktex = { onEdit = false, onOpenAndSave = false },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = { args = {} },
        latexFormatter = "latexindent",
        latexindent = { modifyLineBreaks = false },
      }
    },
  },
  jdtls = {},
  bashls = true,
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  lua_ls = {
    server_capabilities = { semanticTokensProvider = nil },
  },
  pyright = true,
  jsonls = {
    server_capabilities = { documentFormattingProvider = false },
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  cssls = { server_capabilities = { documentFormattingProvider = false } },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' },
      },
    },
  },
  clangd = { init_options = { clangdFileStatus = true }, filetypes = { 'c' } },
  tailwindcss = {
    init_options = {
      userLanguages = {
        elixir = 'phoenix-heex',
        eruby = 'erb',
        heex = 'phoenix-heex',
      },
    },
    filetypes = extend('tailwindcss', 'filetypes', { 'ocaml.mlx' }),
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = { [[class: "([^"]*)]], [[className="([^"]*)]] },
        },
        includeLanguages = extend('tailwindcss', 'settings.tailwindCSS.includeLanguages', {
          ['ocaml.mlx'] = 'html',
        }),
      },
    },
  },
}

-- collect servers for Mason
local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == 'table' then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

-- Mason setup
require('mason').setup()
local ensure_installed = { 'stylua', 'lua_ls' }
vim.list_extend(ensure_installed, servers_to_install)
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- defaults for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- server-specific overrides
for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  vim.lsp.config(name, config)
end

-- enable everything
vim.lsp.enable(vim.tbl_keys(servers))

-- keymaps + autocmds
local disable_semantic_tokens = { lua = true }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local builtin = require 'telescope.builtin'

    local function bufmap(mode, lhs, rhs, desc)
      set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    bufmap('n', 'gd', builtin.lsp_definitions, "Go to definition")
    bufmap('n', 'gr', builtin.lsp_references, "References")
    bufmap('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
    bufmap('n', 'gT', vim.lsp.buf.type_definition, "Type definition")
    bufmap('n', 'K', vim.lsp.buf.hover, "Hover")
    bufmap('n', '<space>rn', vim.lsp.buf.rename, "[R]ename")
    bufmap('n', '<space>ca', vim.lsp.buf.code_action, "[C]ode [A]ction")
    bufmap('n', '<space>wd', builtin.lsp_document_symbols, "[D]ocument symbols")

    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
        end,
      })
    end

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    if disable_semantic_tokens[vim.bo[bufnr].filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end

    local settings = servers[client.name]
    if type(settings) == 'table' and settings.server_capabilities then
      for k, v in pairs(settings.server_capabilities) do
        if v == vim.NIL then
          v = false
        end
        client.server_capabilities[k] = v
      end
    end
  end,
})

-- diagnostics toggle
require('lsp_lines').setup()
vim.diagnostic.config { virtual_text = true, virtual_lines = false }

set('', '<leader>l', function()
  local config = vim.diagnostic.config() or {}
  if config.virtual_text then
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
  else
    vim.diagnostic.config { virtual_text = true, virtual_lines = false }
  end
end, { desc = 'Toggle lsp_lines' })
