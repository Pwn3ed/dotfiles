vim.cmd("highlight MdSpoiler guibg=black guifg=black")

local spoiler = function()
  local id = vim.api.nvim_create_namespace("MdSpoiler")

  local buf = vim.api.nvim_get_current_buf()

  local start_line = 0
  local end_line = vim.api.nvim_buf_line_count(buf)

  for line_num = start_line, end_line - 1 do
    local map_line = vim.api.nvim_buf_get_lines(buf, line_num, line_num + 1, false)[1]

    local start_col = string.find(map_line, ">!")

    if not start_col then
      goto continue
    end

    local end_col = string.find(map_line, "$") - 1

    vim.api.nvim_buf_set_extmark(buf, id, line_num, start_col, {
      hl_group = 'MdSpoiler',
      end_col = end_col,
    })
    ::continue::
  end
end

local id = nil

local function start_spoiler()
  spoiler()
  id = vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChangedI', 'TextChanged', 'TextChangedP' }, {
    pattern = "*.md",
    callback = function()
      spoiler()
    end
  })
end

local function stop_spoiler()
  if id then
    vim.api.nvim_del_autocmd(id)
    vim.cmd("highlight clear MdSpoiler")
    id = nil
  end
end

local command = vim.api.nvim_create_user_command

command('StartSpoiler', function()
  start_spoiler()
end, {})

command('StopSpoiler', function()
  stop_spoiler()
end, {})
