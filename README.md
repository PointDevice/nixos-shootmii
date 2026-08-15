# dbar4gun-nixos

[Dbar4gun](https://github.com/lowlevel-1989/dbar4gun) for NixOS.

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

    dbar4gun-nixos = {
      url = "github:PointDevice/dbar4gun-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
   {
      self,
      nixpkgs,
      bdar4gun-nixos,
    }:
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            dbar4gun-nixos.nixosModules.default
          ];
        };
      };
    };
}
```

Then you can add `xivlauncher-rb` to `configuration.nix` like so:

```nix
{
  config,
  lib,
  pkgs,
  ...
}:
...

environment.systemPackages = [
  dbar4gun
];
```

Now run `sudo nix flake update` in your NixOS configuration directory and rebuild your system as normal. Please note that the previous method of updating Nix channels will no longer work, you will have to use `sudo nix flake update` as long as Flakes are enabled.

## Credits

* [nur-packages-template](https://github.com/nix-community/nur-packages-template) for providing the original template for a Nix Flake
* [drakon64](https://github.com/drakon64) for creating the original repo for xivlauncher-rb for nixos, which this is forked from
