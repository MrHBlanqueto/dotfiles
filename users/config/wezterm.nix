{}:

''
  local wezterm = require('wezterm')

  local font_normal = {  
    family = 'UbuntuMono Nerd Font', 
    weight = 'Regular' 
  }

  local font_fallback_ubuntu = { 
    family = 'UbuntuMono Nerd Font'
  }

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

    inactive_pane_hsb = { 
      saturation = 1.0, 
      brightness = 1.0 
    },

    window_padding = { 
      left = 40, 
      right = 40, 
      top = 40, 
      bottom = 40 
    },

    enable_tab_bar = true,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = false,

    font_size = 10.2,
    line_height = 1.3,

    font = wezterm.font_with_fallback({
      font_normal,
      font_fallback_ubuntu,
      "Twitter Color Emoji",
    }),
    
    font_rules = {
      { 
        italic = true, 
        intensity = 'Normal',
        font = wezterm.font_with_fallback({ 
          { 
            family = 'Victor Mono', 
            style = 'Italic', 
            scale = 0.8 
          }, 
            "Twitter Color Emoji"
        }, 
              { italic = true })
      },

      { 
        italic = true, 
        intensity = 'Bold', 
        font = wezterm.font_with_fallback({ 
          { 
          family = 'Victor Mono', 
          style = 'Italic', 
          weight = 'Bold', 
          scale = 0.8 
        }, 
          "Twitter Color Emoji"
        }, 
            { bold = true, italic = true })
      },

      { 
        italic = false,
        intensity = 'Bold', 
        font = font_with_fallback({ 
          family = 'FiraCode Nerd Font', 
          weight = 'Bold',
          scale = 0.9
        }, 
            { bold = true }) 
      },

      { 
        italic = false,
        intensity = 'Half', 
        font = font_with_fallback({ 
          family = 'FiraCode Nerd Font', 
          weight = 'DemiBold', 
          scale = 0.9
        }) 
      },
    },

    colors = {
      foreground = "#adbac7",
      background = "#050a13",

      cursor_bg = "#adbac7",
      cursor_fg = "#0d1117",
      cursor_border = "#adbac7",

      selection_bg = "#2f3840",
      split = "#232931",

      ansi = {
        "#3B4B58", 
        "#FF958E", 
        "#9DFAAA", 
        "#FBDF90", 
        "#BDfBff", 
        "#E3C9FF", 
        "#B8FFB2", 
        "#F6FAFD"
      },

      brights = {
        "#08101e", 
        "#ea746c", 
        "#7CE38B", 
        "#D9BE74", 
        "#BEDFE8", 
        "#BD89F5", 
        "#94E4A5", 
        "#F6FAFD"
      },

      tab_bar = {
        background = "#010409",

        inactive_tab_edge = "#010409",

        active_tab = {
          bg_color = "#010409",
          fg_color = "#C6CDD5",
          intensity = "Half"
        },

        inactive_tab = { 
          bg_color = "#010409", 
          fg_color = "#3B4B58" 
        },

        inactive_tab_hover = { 
          bg_color = "#010409", 
          fg_color = "#3B4B58" 
        }
      }
    },

    disable_default_key_bindings = true,

    keys = {
      { mods = "CTRL", key = "o", action = wezterm.action { 
        SplitHorizontal = { 
          domain = "CurrentPaneDomain" 
          } 
        } 
      },

      { mods = "CTRL", key = "p", action = wezterm.action { 
        SplitVertical = { 
          domain = "CurrentPaneDomain" 
          } 
        } 
      },

      { mods = "CTRL", key = "t", action = wezterm.action { 
        SpawnTab = "CurrentPaneDomain" 
        } 
      },

      { mods = "CTRL", key = "w", action = wezterm.action { 
        CloseCurrentTab = { 
          confirm = false 
          } 
        } 
      },

      { mods = "CTRL", key = "Tab", action = wezterm.action { 
        ActivateTabRelative = 1 
        } 
      },

      { mods = "CTRL|SHIFT", key = "Tab", action = wezterm.action { 
        ActivateTabRelative = -1 
        } 
      },

      { mods = "CTRL|SHIFT", key = "v", action = wezterm.action { 
        PasteFrom = "Clipboard" 
        } 
      },

      { mods = "CTRL|SHIFT", key = "c", action = wezterm.action { 
        CopyTo = "ClipboardAndPrimarySelection" 
        } 
      },
    },
  }

  return config
''