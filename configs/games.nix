{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [

    # Games
    prismlauncher
    gamescope

  ];
}
