{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/unstable";
  };
  outputs = { self, nixpkgs }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./serverconfig/configuration.nix 
      ];
    };
  };
}