local hooks = require "core.hooks"

local utils = require "core.utils"
local config = utils.load_config()
local maps = config.mappings
local plugin_maps = maps.plugins

hooks.add("setup_mappings", function(map)
   map("n", "<leader>fp", ":Telescope media_files <CR>")
   map("n", "<leader>te", ":Telescope <CR>")

   local m = plugin_maps.lspconfig
   map("n", m.declaration, ":lua vim.lsp.buf.declaration()<CR>")
   map("n", m.definition, ":lua vim.lsp.buf.definition()<CR>")
   map("n", m.hover, ":lua vim.lsp.buf.hover()<CR>")
   map("n", m.implementation, ":lua vim.lsp.buf.implementation()<CR>")
   map("n", m.signature_help, ":lua vim.lsp.buf.signature_help()<CR>")
   map("n", m.add_workspace_folder, ":lua vim.lsp.buf.add_workspace_folder()<CR>")
   map("n", m.remove_workspace_folder, ":lua vim.lsp.buf.remove_workspace_folder()<CR>")
   map("n", m.list_workspace_folders, ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
   map("n", m.type_definition, ":lua vim.lsp.buf.type_definition()<CR>")
   map("n", m.rename, ":lua vim.lsp.buf.rename()<CR>")
   map("n", m.code_action, ":lua vim.lsp.buf.code_action()<CR>")
   map("n", m.references, ":lua vim.lsp.buf.references()<CR>")
   map("n", m.float_diagnostics, ":lua vim.diagnostic.open_float()<CR>")
   map("n", m.goto_prev, ":lua vim.diagnostic.goto_prev()<CR>")
   map("n", m.goto_next, ":lua vim.diagnostic.goto_next()<CR>")
   map("n", m.set_loclist, ":lua vim.diagnostic.setloclist()<CR>")
   map("n", m.formatting, ":lua vim.lsp.buf.formatting()<CR>")
end)
