# NixOS-ShootMii

[ShootMii](https://github.com/PointDevice/ShootMii) for NixOS.

## Installation

Firstly your system must have Flakes enabled. To do this, add the following to your `configuration.nix` file:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Then run `sudo nixos-rebuilt test`, then create a `flake.nix` file in your NixOS configuration directory with the following content:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # This should match the version of NixOS you want to use

    nixos-shootmii = {
      url = "github:PointDevice/nixos-shootmii";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
   {
      self,
      nixpkgs,
      nixos-shootmii,
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            nixos-shootmii.nixosModules.default
          ];
        };
      };
    };
}
```

Then you can add `ShootMii` to `configuration.nix` like so:

```nix
{
  config,
  lib,
  pkgs,
  ...
}:
...

environment.systemPackages = [
  ShootMii
];
```

Now run `sudo nix flake update` in your NixOS configuration directory and rebuild your system as normal. Please note that the previous method of updating Nix channels will no longer work, you will have to use `sudo nix flake update` as long as Flakes are enabled.

## Credits

* [nur-packages-template](https://github.com/nix-community/nur-packages-template) for providing the original template for a Nix Flake
