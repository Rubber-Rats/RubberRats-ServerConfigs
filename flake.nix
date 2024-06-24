{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
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

              
          modules = [ 
            ./serverconfig/configuration.nix 
          ];
      };
    };
  };
}