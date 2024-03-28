
{ config, pkgs, ... }:

{
  security.pam.services.swaylock = {};

  home-manager.users.jotix = { pkgs, ... }: {

    home.packages = with pkgs; [
      wlr-randr
    ];
    
    programs.swaylock = {
      enable = true;
      settings = {
        color = "000000";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        line-color = "ffffff";
        show-failed-attempts = true;
      };
    };

    services.swayidle = {
      enable = true;
      timeouts = [
        { timeout = 60; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
        #{ timeout = 90; command = "${pkgs.systemd}/bin/systemctl suspend"; }
      ];
    };

    programs.wofi = {
      enable = true;
      style = ''
window {
margin: 0px;
border: 1px solid #bd93f9;
background-color: #282a36;
}

#input {
margin: 5px;
border: none;
color: #f8f8f2;
background-color: #44475a;
}

#inner-box {
margin: 5px;
border: none;
background-color: #282a36;
}

#outer-box {
margin: 5px;
border: none;
background-color: #282a36;
}

#scroll {
margin: 0px;
border: none;
}

#text {
margin: 5px;
border: none;
color: #f8f8f2;
} 

#entry.activatable #text {
color: #282a36;
}

#entry > * {
color: #f8f8f2;
}

#entry:selected {
background-color: #44475a;
}

#entry:selected #text {
font-weight: bold;
}
      '';
    };
    
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        #monitor=name,resolution,position,scale
        monitor = [
          "HDMI-A-1,disable"
          "DP-1, 1920x1080, 0x0, 1"
        ];
        env = "XCURSOR_SIZE,24";
        input = {
          kb_layout = "us";
          kb_variant = "altgr-intl";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = "no";
          };
          sensitivity = "0 # -1.0 - 1.0, 0 means no modification.";
        };
        exec-once = [ "waybar" ];
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };
        decoration = {
          rounding = 10;
          drop_shadow = "yes";
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };
        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = "yes"; # you probably want this
        };
        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = "true";
        };
        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = "off";
        };
        # window rules
        windowrulev2 = [
          "workspace 2, class:^(firefox)$"
        ];
        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, return, exec, kitty"
          "$mainMod, X, killactive, "
          "$mainMod SHIFT, x, exit, "
          "$mainMod, H, exec, thunar"
          "$mainMod, V, togglefloating, "
          "$mainMod, D, exec, wofi --show drun"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"
          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          # Switch workspaces with mainMod + [0-9]
          "$mainMod, Q, workspace, 1"
          "$mainMod, W, workspace, 2"
          "$mainMod, E, workspace, 3"
          "$mainMod, R, workspace, 4"
          "$mainMod, T, workspace, 5"
          "$mainMod, Y, workspace, 6"
          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, Q, movetoworkspace, 1"
          "$mainMod SHIFT, W, movetoworkspace, 2"
          "$mainMod SHIFT, E, movetoworkspace, 3"
          "$mainMod SHIFT, R, movetoworkspace, 4"
          "$mainMod SHIFT, T, movetoworkspace, 5"
          "$mainMod SHIFT, Y, movetoworkspace, 6"
          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, F, fullscreen"
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          # reload waybar
          "$mainMod SHIFT, B, exec, killall .waybar-wrapped && waybar &"
          # swaylock
          "$mainMod, L, exec, swaylock -Ff"
        ];
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
