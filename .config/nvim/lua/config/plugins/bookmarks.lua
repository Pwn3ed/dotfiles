return {
  {
    "MattesGroeger/vim-bookmarks",
    config = function()
      vim.g.bookmark_save_per_working_dir = 1
      vim.g.bookmark_auto_save = 1

      local set = vim.keymap.set

      set('n', '<Leader>b<Leader>', '<Plug>BookmarkToggle')
      set('n', '<Leader>bi', '<Plug>BookmarkAnnotate')
      set('n', '<Leader>ba', '<Plug>BookmarkShowAll')
      set('n', '<Leader>bj', '<Plug>BookmarkNext')
      set('n', '<Leader>bk', '<Plug>BookmarkPrev')
      set('n', '<Leader>bc', '<Plug>BookmarkClear')
      set('n', '<Leader>bx', '<Plug>BookmarkClearAll')
      set('n', '<Leader>bkk', '<Plug>BookmarkMoveUp')
      set('n', '<Leader>bjj', '<Plug>BookmarkMoveDown')
      set('n', '<Leader>bg', '<Plug>BookmarkMoveToLine')
    end
  }
}
