local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Dracula"
config.font = wezterm.font("Fira Code")
config.font_size = 10

config.window_background_opacity = 0.85

return config
