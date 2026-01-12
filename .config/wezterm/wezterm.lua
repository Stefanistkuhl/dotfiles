local wezterm = require("wezterm")

local config = wezterm.config_builder()
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").moon

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.colors = theme.colors()
config.window_frame = theme.window_frame()
config.default_prog = { "/usr/bin/fish" }
config.window_background_opacity = 0.69
config.font = wezterm.font("Noto Sans Mono")
config.font_size = 12
config.harfbuzz_features = { "calt=0" }
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
