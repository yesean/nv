local present, lspconfig = pcall(require, "lspconfig")
local servers = require "plugins.configs.servers"

if not present then
   return
end

local M = {}
local utils = require "core.utils"

require("plugins.configs.others").lsp_handlers()

-- Borders for LspInfo window
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
   local opts = _default_opts(options)
   opts.border = "single"
   return opts
end

M.on_attach = function(client, bufnr)
   client.resolved_capabilities.document_formatting = false
   client.resolved_capabilities.document_range_formatting = false

   local lsp_mappings = utils.load_config().mappings.lspconfig
   utils.load_mappings({ lsp_mappings }, { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
   documentationFormat = { "markdown", "plaintext" },
   snippetSupport = true,
   preselectSupport = true,
   insertReplaceSupport = true,
   labelDetailsSupport = true,
   deprecatedSupport = true,
   commitCharactersSupport = true,
   tagSupport = { valueSet = { 1 } },
   resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
   },
}

for name, config in pairs(servers) do
   local opts = {
      on_attach = M.on_attach,
      capabilities = capabilities,
   }
   vim.tbl_deep_extend("force", opts, config)

   print("setting up lsp:", name)
   lspconfig[name].setup(opts)
end

-- requires a file containing user's lspconfigs
local addlsp_confs = utils.load_config().plugins.options.lspconfig.setup_lspconf

if #addlsp_confs ~= 0 then
   require(addlsp_confs).setup_lsp(M.on_attach, capabilities)
end

return M
