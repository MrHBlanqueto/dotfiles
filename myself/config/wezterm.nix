{}:

''
local wezterm = require('wezterm')
-- Usamos el config_builder oficial
local config = wezterm.config_builder()

local font_name = "UbuntuMono Nerd Font"

local function font_with_fallback(name, params)
  local names = {name, "Twitter Color Emoji"}
  return wezterm.font_with_fallback(names, params)
end

config.front_end = 'OpenGL'
config.enable_wayland = true
config.warn_about_missing_glyphs = true
config.check_for_updates = false 
config.bold_brightens_ansi_colors = true  
config.default_cursor_style = 'BlinkingUnderline'
config.window_close_confirmation = 'NeverPrompt'
config.inactive_pane_hsb = {saturation = 1.0, brightness = 1.0}
config.window_padding = {left = 34, right = 34, top = 34, bottom = 34}

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false

config.font_size = 10.2
config.line_height = 1.3
config.font = font_with_fallback(font_name)
config.font_rules = {
  { italic = true, font = font_with_fallback(font_name, {italic = true}) }, 
  { italic = true, intensity = 'Bold', font = font_with_fallback(font_name, {bold = true, italic = true}) }, 
  { intensity = 'Bold', font = font_with_fallback(font_name, {bold = true}) },
  { intensity = 'Half', font = font_with_fallback(font_name) }
}

config.colors = {
  foreground = "#C6CDD5",
  background = "#0d1117",

  cursor_bg = "#C6CDD5",
  cursor_fg = "#0d1117", 
  cursor_border = "#C6CDD5",
  
  selection_bg = "#213850",
  split = "#3B4B58",
  
  ansi = {
    "#3B4B58", "#FF958E", "#9DFAAA", "#FBDF90", "#BDfBff", "#E3C9FF", "#B8FFB2", "#F6FAFD"
  },
  brights = {
    "#363B42", "#ea746c", "#7CE38B", "#D9BE74", "#BEDFE8", "#BD89F5", "#94E4A5", "#F6FAFD"
  },
  tab_bar = {
    background = "#010409",
    inactive_tab_edge = "#010409",
    active_tab = {
      bg_color = "#010409",
      fg_color = "#C6CDD5",
      intensity = "Half"
    },
    inactive_tab = {bg_color = "#010409", fg_color = "#3B4B58"},
    inactive_tab_hover = {bg_color = "#010409", fg_color = "#3B4B58"}
  }
}

config.disable_default_key_bindings = true
config.keys = {
  { mods = "CTRL", key = "o", action = wezterm.action {SplitHorizontal = {domain = "CurrentPaneDomain"}} }, 
  { mods = "CTRL", key = "p", action = wezterm.action {SplitVertical = {domain = "CurrentPaneDomain"}} },
  { mods = "CTRL", key = "t", action = wezterm.action {SpawnTab = "CurrentPaneDomain"} }, 
  { mods = "CTRL", key = "w", action = wezterm.action {CloseCurrentTab = {confirm = false}} },
  { mods = "CTRL", key = "Tab", action = wezterm.action {ActivateTabRelative = 1} }, 
  { mods = "CTRL|SHIFT", key = "Tab", action = wezterm.action {ActivateTabRelative = -1} }, 
  { mods = "CTRL|SHIFT", key = "v", action = wezterm.action {PasteFrom = "Clipboard"} },
  { mods = "CTRL|SHIFT", key = "c", action = wezterm.action {CopyTo = "ClipboardAndPrimarySelection"} }
}

return config
''