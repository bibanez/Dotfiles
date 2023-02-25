{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Terminal
    wezterm
    htop
    neofetch
    git
    unzip
    
    # Security
    git-crypt
    gnupg
    pinentry_qt

    # Common
    firefox
    deluge
    libreoffice
    spotify
    tdesktop
    thunderbird
    nicotine-plus
    lollypop
    zathura
    todoist-electron
    xfce.thunar

    # Editor
    rnix-lsp
    joplin
    joplin-desktop
    
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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "poetry" ];
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
    options = {
      selection-clipboard = "clipboard";
    };
  };
  
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jdinhlife.gruvbox
      ms-toolsai.jupyter
      ms-python.python
      ms-vscode.cpptools
      bbenoist.nix
    ];
  };

  home.stateVersion = "22.11";
}
