{ config, pkgs, lib, ... }:
{
  services.syncthing = {
    enable = true;
    dataDir = "/home/bibanez";
    openDefaultPorts = true;
    configDir = "/home/bibanez/.config/syncthing";
    user = "bibanez";
    group = "users";
    guiAddress = "0.0.0.0:8384";

    overrideDevices = true;
    overrideFolders = true;

    devices = {
      "iPad" = { id = "EZVOL7N-PPJGH6Q-3UDILET-UKK3RZF-Y32JKDR-BENNQSE-PAYJJPF-FFCXZQO"; }; 
    };
    
    folders = {
      "Universitat" = {
        path = "/home/bibanez/Universitat";
        devices = [ "iPad" ];
      };
    };
  };
}
