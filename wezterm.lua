local wezterm = require("wezterm")
local mux = wezterm.mux

config = wezterm.config_builder()
appearance = wezterm.gui.get_appearance()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.font = wezterm.font({family = 'Maple Mono Normal NL NF CN', weight = 'Bold'})
config.font_size = 10
config.initial_cols = 300
config.initial_rows = 300
config.enable_kitty_keyboard = false
config.canonicalize_pasted_newlines = "LineFeed"
config.term = 'xterm-256color'
-- config.default_prog = {"/bin/zsh", "-l", "-c", "tmux source-file ~/.tmux.conf; exec tmux"}
config.default_prog = {"/bin/zsh", "-l", "-c", "exec tmux"}
config.disable_default_mouse_bindings = false
config.bypass_mouse_reporting_modifiers = ''
config.enable_scroll_bar = false
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 120
config.max_fps = 120
config.window_padding = { left = 15, right = 15, top = 15, bottom = 10 }

config.keys = {
    {
        key = "t",
        mods = "CMD",
        action = wezterm.action.SendKey { key = "t", mods = "ALT" },
    },
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action.SendKey {key = "w", mods = "ALT"},
    },
    {
        key = "q",
        mods = "CMD",
        action = wezterm.action_callback(function(win, pane)
            os.execute("/opt/homebrew/bin/tmux kill-server")
            win:perform_action(wezterm.action.QuitApplication, pane)
        end),
    },
    { key = 'LeftArrow',  mods = 'CMD', action = wezterm.action.SendKey { key = 'LeftArrow',  mods = 'ALT' } },
    { key = 'RightArrow', mods = 'CMD', action = wezterm.action.SendKey { key = 'RightArrow', mods = 'ALT' } },
    { key = 'UpArrow',    mods = 'CMD', action = wezterm.action.SendKey { key = 'UpArrow',    mods = 'ALT' } },
    { key = 'DownArrow',  mods = 'CMD', action = wezterm.action.SendKey { key = 'DownArrow',  mods = 'ALT' } },
    {
        key = "b",
        mods = "CMD",
        action = wezterm.action_callback(function(window, pane)
            pane:inject_output('\x1b[?2004l')
        end),
    },
    {
        key = "T",
        mods = "CMD|SHIFT",
        action = wezterm.action.SendString("tmux clone-window\r"),
    },
    {
        key = "Tab",
        mods = "CTRL",
        action = wezterm.action.SendKey { key = "Tab", mods = "CTRL" }
    },
    {
        key = "Tab",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SendKey { key = "Tab", mods = "CTRL|SHIFT" }
    },
    {
        key = "Backspace",
        mods = "CMD",
        action = wezterm.action.SendString("\x15"), -- Ctrl+U
    },
    {
        key = "Backspace",
        mods = "ALT",
        action = wezterm.action.SendString("\x17"), -- Ctrl+W
    },
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = wezterm.action.SendKey { key = 'f', mods = 'ALT' },
    },
    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = wezterm.action.SendKey { key = 'b', mods = 'ALT' },
    },
    {
        key = "[",
        mods = "CTRL|ALT",
        action = wezterm.action.SendKey { key = "LeftArrow", mods = "CTRL|ALT" },
    },
    {
        key = "]",
        mods = "CTRL|ALT",
        action = wezterm.action.SendKey { key = "RightArrow", mods = "CTRL|ALT" },
    },
    {
        key = 'P',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ActivateCommandPalette,
    },
    {
        key = '/',
        mods = 'CTRL',
        action = wezterm.action.SendString('\x00[') -- Ctrl+Space, active tmux copy mode
    },
    {
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ResetTerminal,
    }
}

if appearance:find("Dark") then
    config.color_scheme = 'Default (dark) (terminal.sexy)'
    config.colors = {
        background = "#000000",
    }
else
    config.color_scheme = "Github (base16)"
    config.colors = {
        background = "#ffffff",
    }
end

config.set_environment_variables = {
    WEZTERM_APPEARANCE = wezterm.gui.get_appearance()
}

return config

