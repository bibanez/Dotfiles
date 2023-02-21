[Vídeo](https://www.youtube.com/watch?v=Dy3KHMuDNS8&list=PL-saUBvIJzOkjAw_vOac75v-x6EzNzZq-&index=3)

# Instal·lació

Utilitzant la interfaç gràfica de l'instal·lador

# Home Manager
```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager

sudo nix-channel --update
```

/etc/nixos/configuration.nix :
```imports = [ <home-manager/nixos> ];```
