return {
  "hinell/lsp-timeout.nvim",
  -- Disabled: incompatible with Neovim 0.12.
  -- It checks for the legacy :LspStart/:LspStop commands (replaced by the
  -- builtin `:lsp` command in 0.12) and calls client.launch(), which no longer
  -- exists on vim.lsp.Client. It self-disables at startup and errors at runtime.
  -- Re-enable only on Neovim 0.11.x.
  enabled = false,
  dependencies = { "neovim/nvim-lspconfig" },
  init = function()
    vim.g.lspTimeoutConfig = {
      stopTimeout = 999 * 60 * 25, -- ms, timeout before stopping all LSPs
      startTimeout = 999 * 1, -- ms, timeout before restart
      silent = false, -- true to suppress notifications
    }
  end,
}
