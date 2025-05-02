-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = 'Batman'
config.font =
  wezterm.font('JetBrains Mono', { weight = 'Bold' })
config.font_size = 12.3
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0
config.exit_behavior = 'Close'
config.window_close_confirmation = 'NeverPrompt'
config.enable_tab_bar = false
-- and finally, return the configuration to wezterm
return config