-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dms run")
    -- hl.exec_cmd("1password --silent & vesktop &")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("HYPRSHOT_DIR", "/home/linux-maniac/Pictures/screenshots")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        numlock_by_default = true,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
    general = {
        gaps_in = 5,
        gaps_out = 10,

        border_size = 2,

        resize_on_border = false,
        allow_tearing = false,

        layout = "master",
    },
    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 30,
			render_power = 5,
			offset = "0 5",
			color = "rgba(00000070)",
		},
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    master = {
        new_status = "slave",
        mfact = 0.5,
    },
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
    animations = {
        enabled = true,
    },
})

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name      = "vesktop-workspace",
    match     = { initial_class = "vesktop" },
    workspace = "2 silent",
})

-- Your four Picture-in-Picture rules all matched the same title, so they
-- collapse into one hl.window_rule() call with multiple effects.
hl.window_rule({
    name  = "picture-in-picture",
    match = { title = "Picture-in-Picture" },
    float = true,
    pin   = true,
    size  = { 700, 394 },
    move  = { 1851, 1036 },
})

hl.window_rule({
    name  = "gnome-calculator",
    match = { class = "org.gnome.Calculator" },
    float = true,
    size  = { 360, 616 },
    move  = { 1458, 262 },
})

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({ 
    match = { 
        class = "^(xdg-desktop-portal)$" }, 
        float = true 
    }
)

hl.window_rule({
	match = { class = "^(steam)$", title = "^(notificationtoasts)" },
	no_initial_focus = true,
	pin = true,
})

hl.layer_rule({ match = { namespace = "^(quickshell)$" }, no_anim = true })
hl.layer_rule({ match = { namespace = "^dms:.*" }, no_anim = true })

hl.workspace_rule({ workspace = "2", default = true, monitor = "DP-3" })

require("binds")
require("dms.colors")
require("dms.cursor")
require("dms.outputs")
require("dms.windowrules")
require("dms.layout")