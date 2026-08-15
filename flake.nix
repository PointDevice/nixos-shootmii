{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      packages.${system} = rec {
        ShootMii = pkgs.callPackage ./ShootMii { };
        default = dbar4gun;
      };

      overlays.default = import ./overlay.nix;
      nixosModules.default = import ./module.nix;
    };
}
