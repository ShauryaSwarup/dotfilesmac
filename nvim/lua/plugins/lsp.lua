return {
  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clangd",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "gopls",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    -- Add this global on_attach function
    on_attach = function(client, bufnr)
      -- Improved attachment strategy
      client.attached_buffers = client.attached_buffers or {}
      if not client.attached_buffers[bufnr] then
        client.attached_buffers[bufnr] = true
        vim.lsp.buf_attach_client(bufnr, client.id)
      end

      -- Special handling for full-buffer replacement
      vim.api.nvim_create_autocmd("TextChanged", {
        buffer = bufnr,
        callback = function()
          if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
            vim.schedule(function()
              vim.lsp.buf_detach_client(bufnr, client.id)
              vim.lsp.buf_attach_client(bufnr, client.id)
            end)
          end
        end,
      })
    end,
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--query-driver=/opt/homebrew/bin/g++",
          },
          init_options = {
            compilationDatabasePath = ".",
          },
        },
      },
    },
  },

  {
    "nvim-cmp",
    -- dependencies = { "hrsh7th/cmp-emoji", "saadparwaiz1/cmp_luasnip" },
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      -- opts.snippet = {
      --   expand = function(args)
      --     require("luasnip").lsp_expand(args.body)
      --   end,
      -- }
      table.insert(opts.sources, { name = "emoji" })
      -- table.insert(opts.sources, { name = "luasnip" })
    end,
  },
}
