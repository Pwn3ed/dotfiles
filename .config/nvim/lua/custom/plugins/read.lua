return {
  {
    dir = '~/Documents/Code/Git/nvim/read.nvim',
    opts = {
      style = 'float',
      replacement = {
        ['&#8221;'] = '”',
        ['&#8230;'] = '…',
        ['&#8220;'] = '“',
        ['&#8217;'] = '’',
        ['&#8216;'] = '‘',
        ['&#8211;'] = '–',
        ['&#8212;'] = '—',
      },
    },
  },
}
