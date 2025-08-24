--- 'quiet'|'unokai'|'solarized-osaka'
vim.cmd.colorscheme 'retrobox'

--- Remove background of colorschemes
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  pattern = "*",
  callback = function()
    local remove_background = {
      'unokai',
      'quiet',
      'retrobox'
    }

    local place_background = {
      'vim'
    }

    for _, colorscheme in pairs(remove_background) do
      if vim.g["colors_name"] == colorscheme then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatFooter", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLineSign", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorColumn", { bg = "none" })
      end
    end

    for _, colorscheme in pairs(place_background) do
      if vim.g["colors_name"] == colorscheme then
        vim.api.nvim_set_hl(0, "Normal", { bg = "#444444" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#444444" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#444444" })
        vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#444444" })
        vim.api.nvim_set_hl(0, "FloatFooter", { bg = "#444444" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#444444" })
      end
    end
  end
})
