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
	top = 2,
	bottom = 0,
}

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
config.font = wezterm.font("Fira Code")
config.font_size = 10

config.window_background_opacity = 0.75

config.leader = { key = '§', timeout_milliseconds = 1000 }
config.keys = {
	{
		key = '\\',
		mods = 'LEADER',
		---@diagnostic disable-next-line: undefined-field
		action = wezterm.action.SplitHorizontal
	},
	{
		key = '-',
		mods = 'LEADER',
		---@diagnostic disable-next-line: undefined-field
		action = wezterm.action.SplitVertical
	},
	---@diagnostic disable-next-line: undefined-field
	{ key = "h", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Left" } },
	---@diagnostic disable-next-line: undefined-field
	{ key = "j", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Down" } },
	---@diagnostic disable-next-line: undefined-field
	{ key = "k", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Up" } },
	---@diagnostic disable-next-line: undefined-field
	{ key = "l", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Right" } },
	---@diagnostic disable-next-line: undefined-field
	{ key = "w", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
}

return config
