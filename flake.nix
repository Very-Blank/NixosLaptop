{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs: let
    inherit (inputs) home-manager nixpkgs niri;
    system = "x86_64-linux"; in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        niri.nixosModules.niri
      ];

      specialArgs = { inherit inputs system; };
    };

    homeConfigurations.blank = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./home.nix
        niri.homeModules.niri
      ];

      extraSpecialArgs = { inherit inputs system; };
    };
  };
}
