-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local home = os.getenv 'HOME'

return {
  { 'ThePrimeagen/vim-be-good' },
  -- { 'leonardo-luz/floatwindow.nvim' },
  -- { 'leonardo-luz/ai.nvim' },
  -- { 'leonardo-luz/present.nvim' },
  -- Local plugins
  -- { dir = '~/Documents/Code/Git/nvim/floatwindow.nvim' },
  { dir = '~/Documents/Code/Git/nvim/present.nvim' },
  { dir = '~/Documents/Code/Git/nvim/ai.nvim' },
  { dir = '~/Documents/Code/Git/nvim/training.nvim' },
  { dir = '~/Documents/Code/Git/nvim/floatwindow.nvim' },
  { dir = '~/Documents/Code/Git/nvim/tetris.nvim' },
  { dir = '~/Documents/Code/Git/nvim/aichat.nvim' },
  { dir = '~/Documents/Code/Git/nvim/type.nvim', opts = {
    words = 30,
  } },
  {
    dir = '~/Documents/Code/Git/nvim/quicknotes.nvim',
    opts = {
      path = home .. '/Documents/Obsidian/Stuff/Quicknotes',
      vim.keymap.set('n', '<leader>np', '<cmd>Quicknote<CR>', { desc = 'Quick[N]ote [P]revious' }),
      vim.keymap.set('n', '<leader>nn', '<cmd>QuicknoteNew<CR>', { desc = 'Quick[N]ote [N]ew' }),
      vim.keymap.set('n', '<leader>nl', '<cmd>QuicknoteList<CR>', { desc = 'Quick[N]ote [L]ist' }),
      vim.keymap.set('n', '<leader>nd', '<cmd>QuicknoteDelete<CR>', { desc = 'Quick[N]ote [D]elete' }),
    },
  },
}
