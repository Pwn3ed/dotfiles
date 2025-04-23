local floatwindow = require 'floatwindow'

local state = {
  window = {
    floating = {
      buf = -1,
      win = -1,
    },
    opts = {},
    enter = false,
  },
}

local create_window_config = function()
  local width = vim.o.columns
  local height = vim.o.lines

  return {
    relative = 'editor',
    style = 'minimal',
    zindex = 1,
    width = width - 50,
    height = height,
    col = 50,
    row = 0,
    border = 'rounded',
  }
end

local toggle = function()
  if not vim.api.nvim_win_is_valid(state.window.floating.win) then
    state.window.opts = create_window_config()
    state.window.floating = floatwindow.create_floating_window(state.window)

    vim.cmd 'DBUIToggle'

    vim.keymap.set('n', '<Esc><Esc>', function()
      vim.cmd 'DBUIToggle'
      vim.api.nvim_win_hide(state.window.floating.win)
    end, { buffer = state.window.floating.buf })
  else
    vim.cmd 'DBUIToggle'
    vim.api.nvim_win_hide(state.window.floating.win)
  end
end

vim.keymap.set('n', '<leader>td', function()
  vim.cmd 'DBUIToggle'
  -- toggle()
end, {
  desc = '[T]oggle [D]atabase',
})

return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
