return {
  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
    opts = {
      vim.keymap.set('n', '<leader>pm', '<cmd>:Glow<cr>', { desc = '[P]review [M]arkdown' }),
      border = 'rounded',
    },
  },
}
