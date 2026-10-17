-- Bigfoot: ground-station consoles. Windows are dark panes edged by a 1px bigfoot beam
-- (signal mint dissolving into deep-space blue), with tight modern rounding and the faintest
-- cool glow on the focused window.
-- Terminals get their transparency from their own background opacity (ghostty.conf,
-- alacritty.toml, kitty.conf, foot.ini in this theme), so their text stays fully opaque.
-- Hyprland 0.55+ Lua (Omarchy Quattro).
--
-- Only honoured for themes placed by hand in ~/.config/omarchy/themes/
-- (themes installed with `omarchy theme install` have their .lua stripped).

local active_border_color = { colors = { "rgba(3ce8b5e6)", "rgba(106aa8ffcc)" }, angle = 135 }
local inactive_border_color = { colors = { "rgba(5d6f8240)", "rgba(5d6f8212)" }, angle = 135 }

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 1,
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    rounding = 14,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    -- the faintest cool glow on the focused window; a small neutral shadow on the others
    shadow = {
      enabled = true,
      range = 8,
      render_power = 3,
      offset = "0 2",
      color = "rgba(3ce8b522)",   -- signal glow hugging the edge
      color_inactive = "rgba(00000038)",
    },
    -- the glass: a soft frosting, so the night sky stays recognisable behind each window
    blur = {
      enabled = true,
      size = 5,
      passes = 2,
      new_optimizations = true,
      xray = false,
      contrast = 1.0,
      brightness = 0.8,
      noise = 0.01,
      vibrancy = 0.25,
      vibrancy_darkness = 0.4,
      popups = true,
      special = true,
    },
  },
})

-- Apps without their own background opacity turn translucent as a whole, text included, so they
-- keep just a hint of glass and their text stays crisp. Terminals are left to their own
-- (text-preserving) background opacity.
hl.window_rule({
  match = { class = "^(omawrite|com.thisisgm.flea)$" },
  tag = "-default-opacity",
  opacity = "0.92 override 0.88 override",
})

-- The Omarchy shell's own surfaces (bar, launcher and menus, notifications, OSD, polkit, pickers)
-- get the same soft frosting. ignore_alpha keeps the blur to the panels themselves: the faint
-- full-screen dimming behind menus (scrim, 20%) stays unblurred, so the desktop stays sharp.
hl.layer_rule({
  match = { namespace = "^(omarchy-bar|omarchy-menu|omarchy-notifications|omarchy-osd|omarchy-polkit|omarchy-reminders|omarchy-clipboard|omarchy-emojis|omarchy-image-selector|omarchy-keyboard-panel|omarchy-network-qr)$" },
  blur = true,
  ignore_alpha = 0.3,
})
