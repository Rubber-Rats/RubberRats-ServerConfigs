# Rubber Rats server config

Nixos config for the server

# Important!! the server auto updates using this piece of code from our git repo so make sure to always commit your changes to github!

```nix
  system.autoUpgrade = {
    enable = true;
    flake = "github:Rubber-Rats/RubberRats-ServerConfigs";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
 
```

Rebuild the server with this command while logged in via ssh:

```sh
sudo nixos-rebuild switch
```

# How do I remote deploy this from a nixos machine?

```sh
nix-shell -p colmena
colmena apply --impure
```
