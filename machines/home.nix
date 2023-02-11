{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    htop
    neofetch
    firefox
    helix
    rnix-lsp
    git
    git-crypt
    gnupg
    pinentry_qt
    sway
    clipman
    wezterm
    swaynotificationcenter
    fuzzel
    brightnessctl
    playerctl
    cinnamon.nemo
    deluge
    libreoffice
    spotify
  ];
  gtk = {
    enable = true;    
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
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
        "${modifier}+n" = "exec nemo";
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
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
  programs.wezterm = {
    enable = true;
    extraConfig = "
      local wezterm = require(\"wezterm\")
      
      return {
        hide_tab_bar_if_only_one_tab = true,
        color_scheme = \"GruvboxDark (Gogh)\",
      }
    ";
  };
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
    };
  };
  programs.git = {
    userEmail = "personal@bibanez.xyz";
    userName = "Bernat Ibáñez";
  };
  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  home.stateVersion = "22.11";
}
