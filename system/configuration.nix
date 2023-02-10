# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

    # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #qt5.enable = true;
  #qt5.platformTheme = "gtk2";
  #qt5.style = "gtk2";
  
  # Shell
  programs.zsh.enable = true;
  
  # Sway general config
  security.polkit.enable = true;
  xdg.portal.wlr.enable = true;
  programs.sway.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us,es";
    xkbVariant = ",";
    xkbOptions = "grp:win_space_toggle";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.bibanez = {
    isNormalUser = true;
    description = "Bernat Ibáñez Martínez";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.bibanez = { pkgs, ... }: {
    home.packages = with pkgs; [
      htop
      firefox
      kate
      helix
      git
      git-crypt
      gnupg
      pinentry_qt
      sway
      wezterm
      swaynotificationcenter
      fuzzel
      brightnessctl
      playerctl
      cinnamon.nemo
      deluge
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
            #xkb_layout = "es";
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
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
