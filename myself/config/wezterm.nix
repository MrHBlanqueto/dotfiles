{}:

''
local wezterm = require('wezterm')
local config = wezterm.config_builder()

local font_normal = { family = 'FiraCode Nerd Font', weight = 'Regular' }
local font_bold   = { family = 'FiraCode Nerd Font', weight = 'Bold' }
local font_fallback_ubuntu = { family = 'UbuntuMono Nerd Font' }

local victor_italic = { family = 'Victor Mono', style = 'Italic' }
local victor_bold_italic = { family = 'Victor Mono', style = 'Italic', weight = 'Bold' }
local function font_with_fallback(name, params)

  return wezterm.font_with_fallback({
    name,
    "Twitter Color Emoji",
  }, params)
end

config = {
  front_end = 'OpenGL',
  enable_wayland = true,
  warn_about_missing_glyphs = true,
  check_for_updates = false,
  bold_brightens_ansi_colors = true,
  default_cursor_style = 'BlinkingUnderline',
  window_close_confirmation = 'NeverPrompt',
  inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
  window_padding = { left = 34, right = 34, top = 34, bottom = 34 },

  enable_tab_bar = true,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tab_index_in_tab_bar = false,

  font_size = 9,
  line_height = 1.1,
  font = wezterm.font_with_fallback({
    font_normal,
    font_fallback_ubuntu,
    "Twitter Color Emoji",
  }),
  
  font_rules = {
    { 
      italic = true, 
      intensity = 'Normal',
      font = font_with_fallback(victor_italic, { italic = true }) 
    },

    { 
      italic = true, 
      intensity = 'Bold', 
      font = font_with_fallback(victor_bold_italic, { bold = true, italic = true }) 
    },

    { 
      italic = false,
      intensity = 'Bold', 
      font = font_with_fallback(font_bold, { bold = true }) 
    },

    { 
      italic = false,
      intensity = 'Half', 
      font = font_with_fallback({ family = 'FiraCode Nerd Font', weight = 'DemiBold' }) 
    },
  },

  colors = {
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
      inactive_tab = { bg_color = "#010409", fg_color = "#3B4B58" },
      inactive_tab_hover = { bg_color = "#010409", fg_color = "#3B4B58" }
    }
  },

  disable_default_key_bindings = true,
  keys = {
    { mods = "CTRL", key = "o", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { mods = "CTRL", key = "p", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { mods = "CTRL", key = "t", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { mods = "CTRL", key = "w", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
    { mods = "CTRL", key = "Tab", action = wezterm.action { ActivateTabRelative = 1 } },
    { mods = "CTRL|SHIFT", key = "Tab", action = wezterm.action { ActivateTabRelative = -1 } },
    { mods = "CTRL|SHIFT", key = "v", action = wezterm.action { PasteFrom = "Clipboard" } },
    { mods = "CTRL|SHIFT", key = "c", action = wezterm.action { CopyTo = "ClipboardAndPrimarySelection" } }
  }
}

return config
''