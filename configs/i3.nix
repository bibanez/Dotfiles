{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [

    # Desktop
    feh
    brightnessctl
    playerctl
    pavucontrol
    networkmanagerapplet
    
  ];
  
  xsession.windowManager.i3 = {
    enable = true;      
    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      gaps.inner = 4;
      startup = [{
        command = "${pkgs.feh}/bin/feh --bg-max ../wallpapers/Rembrandt-The_Anatomy_Lesson_of_Dr_Nicolaes_Tulp.jpg";
      }];
      defaultWorkspace = "workspace number 1";
      
      keybindings = lib.mkOptionDefault {
        "${modifier}+Escape" = "exec ${../scripts/powermenu.sh}";
        "${modifier}+b" = "exec firefox";
        "${modifier}+p" = "exec firefox --private-window";
        "${modifier}+n" = "exec thunar";
        "${modifier}+t" = "exec ${../scripts/subjects.sh}";
        "${modifier}+Shift+t" = "exec nemo ~/Current";

        # Focus
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
      
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
      };

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
  };
}
