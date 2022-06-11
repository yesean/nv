return {
   sumneko_lua = {
      settings = {
         Lua = {
            diagnostics = {
               globals = { "vim" },
            },
            workspace = {
               library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
               },
               maxPreload = 100000,
               preloadFileSize = 10000,
            },
         },
      },
   },
   pyright = {},
   tsserver = {
      root_dir = function(fname)
         return require("lspconfig.server_configurations.tsserver").default_config.root_dir(fname) or vim.fn.getcwd()
      end,
   },
   gopls = {},
   clangd = {},
   jdtls = {},
}
