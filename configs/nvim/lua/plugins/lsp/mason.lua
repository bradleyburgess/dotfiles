return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "astro",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "emmet_ls",
        -- "graphql",
        "html",
        "lua_ls",
        "phpactor",
        -- "prismals",
        "pyright",
        -- "ruby_lsp",
        -- "sorbet",
        "solargraph",
        "svelte",
        "tailwindcss",
        "ts_ls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "black", -- python formatter
        "erb-formatter",
        "erb-lint",
        "eslint_d", -- fast eslint
        "isort", -- python formatter
        "prettier", -- prettier formatter
        "pylint",
        -- "rubocop",
        -- "standardrb",
        "stylua", -- lua formatter
      },
    })
  end,
}
