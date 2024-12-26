local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 0.88
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

-- Font
config.font = wezterm.font_with_fallback({
    {
        family = "UbuntuMono Nerd Font Propo",
        weight = "Regular",
    },
})
config.font_size = 18

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity

-- Colors
config.colors = require("boss")
config.force_reverse_video_cursor = true
config.default_cursor_style = "SteadyBar"

-- Tabs
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = true
config.enable_wayland = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false -- Set to false to start tabs at 1
config.hide_mouse_cursor_when_typing = true
--config.window_close_confirmation = "NeverPrompt"

config.colors.tab_bar = {
    background = transparent_bg,
    new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
    active_tab = { bg_color = "#62b551", fg_color = config.colors.background },
}

-- tmux
config.keys = {
    {
        mods = "ALT",
        key = "e",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        mods = "ALT",
        key = "w",
        action = wezterm.action.CloseCurrentPane({ confirm = true }),
    },
    {
        mods = "ALT",
        key = "[",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        mods = "ALT",
        key = "]",
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        mods = "ALT",
        key = "f",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "ALT",
        key = "v",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        mods = "ALT",
        key = "h",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        mods = "ALT",
        key = "j",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        mods = "ALT",
        key = "k",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        mods = "ALT",
        key = "l",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        mods = "ALT",
        key = "H",
        action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
    },
    {
        mods = "ALT",
        key = "L",
        action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
    },
    {
        mods = "ALT",
        key = "J",
        action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
    },
    {
        mods = "ALT",
        key = "K",
        action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
    },
}

for i = 1, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

return config
