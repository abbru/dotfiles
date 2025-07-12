return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      astro = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
    },
    format_on_save = { -- Esto activa el formateo al guardar
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
}
