return {
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true
      }
    },
    dependencies = {
      { 'echasnovski/mini.icons', opts = {} },
    },
    init = function()
      require 'config.oil'
    end,
  },
}
