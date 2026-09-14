-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do not use existing file picker
vim.keymap.del("n", "<leader><leader>")
vim.keymap.set("n", "<leader><leader>", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = false,
    find_command = {
      "fd",
      "--type",
      "f",
      "--hidden",
      "--follow",
      "--exclude",
      "graphify-out",
    },
  })
end, { desc = "Find Files (Root Dir)" })

keymap.set("n", "x", '"_x')

keymap.set("n", "<C-/>", "<cmd>ToggleTerm<cr>", opts)

-- Escape using jk
keymap.set("i", "jk", "<Esc>", opts)

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", function()
  vim.cmd.normal({ "ggVG", bang = true })
end, { silent = true })

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- root dir
vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle<CR>", { desc = "Explorer NeoTree (root dir)" })

-- reveal current buffer in neotree
vim.keymap.set("n", "<leader>fe", function()
  local current_file = vim.fn.expand("%:p")
  if current_file ~= "" then
    vim.cmd("Neotree reveal " .. current_file)
  else
    vim.cmd("Neotree toggle")
  end
end, { desc = "Reveal current file in NeoTree" })

-- Oil (create/rename/delete files & folders)
keymap.set("n", "<leader>o", ":Oil<Return>", opts)

-- current dir (with safety check)
keymap.set("n", "<leader>e", function()
  local current_file = vim.fn.expand("%:p")
  if current_file ~= "" and vim.fn.isdirectory(vim.fn.expand("%:p:h")) == 1 then
    vim.cmd("Neotree toggle dir=" .. vim.fn.expand("%:p:h"))
  else
    vim.cmd("Neotree toggle")
  end
end, { desc = "Explorer NeoTree (cwd)" })

-- File explorer with NvimTree
-- keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
-- keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Competitest
keymap.set("n", "<Leader>cprc", ":CompetiTest receive contest<Return>", opts)
keymap.set("n", "<Leader>cprp", ":CompetiTest receive problem<Return>", opts)
keymap.set("n", "<Leader>cps", ":CompetiTest run<Return>", opts)
keymap.set("n", "<Leader>cpu", ":CompetiTest show_ui<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<M-h>", "5<C-w><")
keymap.set("n", "<M-l>", "5<C-w>>")
keymap.set("n", "<M-k>", "5<C-w>+")
keymap.set("n", "<M-j>", "5<C-w>-")

vim.schedule(function()
  vim.keymap.del("i", "<Tab>")
  vim.keymap.set("i", "<Tab>", "<Tab>", { noremap = true, silent = true })
end)
-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
