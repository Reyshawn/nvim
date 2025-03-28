

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.timeoutlen = 0

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.shiftwidth = 2       -- Number of spaces to use for each indentation
vim.opt.tabstop = 2          -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2      -- Makes editing feel like tabs are 2 spaces

vim.opt.fillchars:append({ eob = " " })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File", silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File", silent = true })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { desc = "Save File", silent = true })

vim.keymap.set("n", "<BS>", ":q<CR>", { desc = "Close a file" })
vim.keymap.set("n", "<leader>q", ":qa!<CR>", { desc = "Quit!" })

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })
vim.keymap.set("n", "<leader>j", "<cmd>Neotree reveal<cr>", { desc = "Reveal current file in tree" })

-- Directional split navigation
vim.keymap.set("n", "<leader><Left>",  "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<leader><Down>",  "<C-w>j", { desc = "Move to bottom split" })
vim.keymap.set("n", "<leader><Up>",    "<C-w>k", { desc = "Move to top split" })
vim.keymap.set("n", "<leader><Right>", "<C-w>l", { desc = "Move to right split" })


-- Gitsings Keymaps
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    local gs = package.loaded.gitsigns

    vim.keymap.set("n", "]c", gs.next_hunk, { desc = "Next Git hunk" })
    vim.keymap.set("n", "[c", gs.prev_hunk, { desc = "Previous Git hunk" })
    vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
    vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
    vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
    vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
    vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
    vim.keymap.set("n", "<leader>gi", gs.preview_hunk_inline, { desc = "Preview hunk in line" })
    vim.keymap.set("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
  end,
})

vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { desc = "LSP code action." })


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
