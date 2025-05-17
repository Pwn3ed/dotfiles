local esc          = vim.api.nvim_replace_termcodes('<ESC>', true, true, true)
local command      = vim.api.nvim_create_user_command

local macros_js    = function()
  local log = string.format('yoconsole.log("%spa: ", %spA);%sO%sjviq', esc, esc, esc, esc)
  local try = string.format('Otry{%sjo} catch(err) {%soerr%shviw@l%skkdjo}%s', esc, esc, esc, esc, esc)

  vim.fn.setreg('l', log)
  vim.fn.setreg('t', try)
end

local macros_nvim  = function()
  local log = string.format('yovim.print("%spa: ", %spA);%sO%sjviq', esc, esc, esc, esc)

  vim.fn.setreg('l', log)
end

local macros_latex = function()
  local fixme = string.format('S{lxh%%hx%%i\\fixme%s', esc)

  vim.fn.setreg('l', fixme)
end

macros_js()
