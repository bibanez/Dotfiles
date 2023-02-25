{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [

    # Desktop
    wl-clipboard
    clipman
    swaynotificationcenter
    fuzzel
    brightnessctl
    playerctl
    pavucontrol
    networkmanagerapplet

  ];
  
  wayland.windowManager.sway = {
    enable = true;      
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      colors = {
        focused = {
          border = "#d65d0e";
          background = "#d65d0e";
          text = "#ebdbb2";
          indicator = "#458588";
          childBorder = "#d65d0e";
        };
        unfocused = {
          border = "#282828";
          background = "#282828";
          text = "#ebdbb2";
          indicator = "#282828";
          childBorder = "#282828";
        };
      };
      gaps.inner = 4;
      output = {
        "*" = {
          bg = "${../wallpapers/Rembrandt-The_Anatomy_Lesson_of_Dr_Nicolaes_Tulp.jpg} fill";
        };
        "eDP-1" = {
          pos = "1920 0";
        };
        "DP-2" = {
          pos = "0 0";
        };
      };
      startup = [
        {
          command = "exec wl-paste -t text --watch clipman store --no-persist";
        }
      ];
      menu = "fuzzel -t ebdbb2ff -b 282828dd -m d65d0eff -s 665c54ff -S ebdbb2ff -C d65d0eff | xargs swaymsg exec --";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Escape" = "exec ${../scripts/powermenu.sh}";
        "${modifier}+b" = "exec firefox";
        "${modifier}+p" = "exec firefox --private-window";
        "${modifier}+n" = "exec thunar";
        "${modifier}+t" = "exec ${../scripts/subjects.sh}";
        "${modifier}+Shift+t" = "exec nemo ~/Current";
      
        # Media
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        
        # Notifications
        "${modifier}+Shift+n" = "exec swaync-client -op";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us,es";
          xkb_options = "grp:win_space_toggle";
        };
        "type:touchpad" = {
          tap = "enable";
        };
        #"\"1452:591:Keychron_Keydchron_K3\"" = {
        #  xkb_layout = "us,es";
        #  xkb_options = "grp:win_space_toggle";
        #};
      };
      bars = [
        {
          position = "top";
          mode = "hide";
          trayOutput = "none";
          statusCommand = "while ${../scripts/status.sh}; do sleep1; done";
          fonts = {
            size = 11.0;
          };
          colors = {
            statusline = "#fbf1c7";
            background = "#1d2021";
            inactiveWorkspace = {
              background = "#1d2021";
              border = "#1d2021";
              text = "#ebdbb2";
            };
            focusedWorkspace = {
              background = "#d65d0e";
              border = "#d65d0e";
              text = "#ebdbb2";
            };
          };
        }
      ];
    }; 
    extraConfig = "seat seat0 xcursor_theme Adwaita 24";
  };
}
