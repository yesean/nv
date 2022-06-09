require("null-ls").setup {
   sources = {
      require("null-ls").builtins.diagnostics.pylint,
      require("null-ls").builtins.formatting.yapf,
      require("null-ls").builtins.formatting.isort,
   },
   on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
         vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      end
   end,
}
