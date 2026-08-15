{
  pkgs ? import <nixpkgs> { },
}:
{
  ShootMii = pkgs.callPackage ./ShootMii { };
}
