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
        default = ShootMii;
      };

      overlays.default = import ./overlay.nix;
      nixosModules.default = import ./module.nix;
    };
}
