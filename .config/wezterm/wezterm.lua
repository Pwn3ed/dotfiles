local wezterm = require("wezterm")

local config = {}

--- FIX: wezterm-types isnt working properly
---@diagnostic disable-next-line: undefined-field
if wezterm.config_builder then
	---@diagnostic disable-next-line: undefined-field
	config = wezterm.config_builder()
end

config.window_padding = {
	left = 3,
	right = 0,
	top = 3,
	bottom = 0,
}

config.text_background_opacity = 0.9
config.enable_tab_bar = false

local presets = {
	dark = {
		'#000000',
		'#111111',
		'#000000',
	},
	gray = {
		'#333333',
	},
	light = {
		'#FFFFFF',
		'#FFFFFF',
		'#FFFFFF',
	},
	redish = {
		'#660044',
		'#880022',
	},
	default = {
		'#442233',
		'#000000',
		'#221122',
	},
}

---@param preset_num string
---@param orientation 'Horizontal'|'Vertical'
---@param noise number
---@return table
local function set_background_gradiant(preset_num, orientation, noise)
	return {
		orientation = orientation,

		colors = presets[preset_num],

		interpolation = 'Linear',
		noise = noise,

		blend = 'Rgb',
	}
end

local current_gradiant = "default"
config.window_background_gradient = set_background_gradiant(current_gradiant, 'Vertical', 64)

config.color_scheme = "Dracula"
config.font = wezterm.font("Fira Code Nerd Font")
config.font_size = 10

config.window_background_opacity = 0.75

-- ---@diagnostic disable-next-line: undefined-field
-- wezterm.on('update-right-status', function(window, pane)
-- 	window:set_right_status(window:active_workspace())
-- end)

---@diagnostic disable-next-line: undefined-field
local act = wezterm.action

config.leader = { key = 'b', mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = 'v',
		mods = 'LEADER|CTRL',
		action = act.SplitHorizontal
	},
	{
		key = 'h',
		mods = 'LEADER|CTRL',
		action = act.SplitVertical
	},
	{ key = "h", mods = "LEADER",      action = act { ActivatePaneDirection = "Left" } },
	{ key = "j", mods = "LEADER",      action = act { ActivatePaneDirection = "Down" } },
	{ key = "k", mods = "LEADER",      action = act { ActivatePaneDirection = "Up" } },
	{ key = "l", mods = "LEADER",      action = act { ActivatePaneDirection = "Right" } },

	{ key = "w", mods = "LEADER|CTRL", action = act { CloseCurrentPane = { confirm = true } } },
	{ key = "l", mods = "LEADER|CTRL", action = act.ShowDebugOverlay },

	-- {
	-- 	key = 'y',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = act.SwitchToWorkspace {
	-- 		name = 'default',
	-- 	},
	-- },
	-- -- Switch to a monitoring workspace, which will have `top` launched into it
	-- {
	-- 	key = 'u',
	-- 	mods = 'CTRL|SHIFT',
	-- 	action = act.SwitchToWorkspace {
	-- 		name = 'monitoring',
	-- 		spawn = {
	-- 			args = { 'top' },
	-- 		},
	-- 	},
	-- },
	-- { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
	-- {
	-- 	key = '9',
	-- 	mods = 'ALT',
	-- 	action = act.ShowLauncherArgs {
	-- 		flags = 'FUZZY|WORKSPACES',
	-- 	},
	-- },
}

-- config.unix_domains = {
-- 	{
-- 		name = 'unix',
-- 	},
-- }

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
-- config.default_gui_startup_args = { 'connect', 'unix' }

return config
