{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, colmena}: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [];
        };
      };

      rubberrats = {
        deployment = {
          targetHost = "rubberroomwithrats.com";
            targetPort = 22;
            targetUser = "root";
          };

          imports = [ 
            ./serverconfig/configuration.nix 
          ];
      };
    };
  };
}