-- NOTE: COMMANDS
vim.api.nvim_create_user_command('Xmage', function()
  vim.cmd '!cd ~/Documents/Games/x_mage/game/ && java -jar XMageLauncher-0.3.8.jar'
end, {})

vim.api.nvim_create_user_command('Aqw', function()
  vim.cmd '!cd ~/Documents/Games && ./aqw.AppImage'
end, {})

vim.api.nvim_create_user_command('Minecraft', function()
  vim.cmd '!cd ~/Documents/Games/TLauncher.v10 && java -jar TLauncher.jar'
end, {})

-- NOTE: KEYMAPS NORMAL MODE
return {}
