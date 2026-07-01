# livnote-nix
Packages the Livnote application from https://www.osvauld.com/livnote/ into nix

This doesn't build from source it just takes the .deb and repackages it to be used with nix
This is my first time packaging any application for Nix I might not be doing it perfectly I followed a tutorial on this blog
https://dev.to/oxcl/how-i-packaged-a-deb-file-for-nixos-with-flakes-5dn
I didn't do it exactly how they did

Flake support is gonna come I just gotta figure out how to do it first since I've never done it
If you need any help just message me on matrix @mobanerd:matrix.org


To install this just take the osvauld.nix and put it in your /etc/nixos
And then add this in your environment.systemPackages or home.packages
```
(pkgs.callPackage ./osvauld.nix {})
```
Feel free to review the code in osvauld.nix and give me any tips since I'm very new to this I just did it since i needed this app and it wasnt in nixpkgs
Also the app is called osvauld even though it's supposed to be called Livnote i think
