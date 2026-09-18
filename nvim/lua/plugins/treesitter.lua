local parsers = {
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "html",
  "css",
  "prisma",
  "markdown",
  "markdown_inline",
  "svelte",
  "graphql",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
  "query",
  "vimdoc",
  "c",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",

    -- The new main branch explicitly does not support lazy-loading.
    lazy = false,

    build = ":TSUpdate",

    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        opts = {},
      },
    },

    opts = {
      -- Declaratively ensure parsers are installed without reinstalling on every launch
      ensure_installed = parsers,
      -- Set to true if you don't want notifications when parsers auto-install
      sync_install = false,
      auto_install = true,
    },

    config = function(_, opts)
      local treesitter = require("nvim-treesitter")

      treesitter.setup(opts)

      -- REMOVED: treesitter.install(parsers)
      -- Parsers will now only compile once upon update or missing status, rather than every startup.

      local filetypes = {
        "json",
        "jsonc",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "svelte",
        "graphql",
        "sh",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "c",
      }

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter_start", { clear = true }),
        pattern = filetypes,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)

          -- Experimental Treesitter indentation.
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
