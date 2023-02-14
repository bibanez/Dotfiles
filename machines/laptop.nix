{ config, pkgs, lib, ... }:

{
  imports = [ ./sway.nix ];

  home.packages = with pkgs; [
    # Terminal
    wezterm
    htop
    neofetch
    git
    
    # Security
    git-crypt
    gnupg
    pinentry_qt

    # Common
    firefox
    deluge
    libreoffice
    spotify
    cinnamon.nemo
    tdesktop
    thunderbird
    nicotine-plus
    lollypop
    zathura

    # Editor
    helix
    rnix-lsp
    
    # Desktop
    sway
    wl-clipboard
    clipman
    swaynotificationcenter
    fuzzel
    brightnessctl
    playerctl
    pavucontrol
    networkmanagerapplet
  ];
  
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
    gtk.enable = true;
  };

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
    # cursorTheme = {
    #   name = "Vanilla-DMZ";
    #   package = pkgs.vanilla-dmz;
    # };
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
      editor = {
        line-number = "relative";
      };
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
  
  programs.zathura = {
    enable = true;
    
  };

  home.stateVersion = "22.11";
}
