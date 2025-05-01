return {
  {
    dir = "~/Documents/Code/Git/nvim/wallpaper.nvim/",
    opts = {
      cmd = {
        "WallpaperAdd",
        "WallpaperList",
        "WallpaperListDelete",
      },
      keys = {
        { 'n', '<leader>wa', '<cmd>WallpaperAdd<cr>',        { desc = "[W]allpaper [A]dd" } },
        { 'n', '<leader>wl', '<cmd>WallpaperList<cr>',       { desc = "[W]allpaper [L]ist" } },
        { 'n', '<leader>wd', '<cmd>WallpaperListDelete<cr>', { desc = "[W]allpaper list [D]elete" } },
      },
    }
  }
}
