{
  lib,
  python313Packages,
  fetchFromGitHub,
  versionCheckHook,
  writableTmpDirAsHomeHook,
  runCommand,
}:

let
in
python313Packages.buildPythonApplication rec {
  pname = "ShootMii";
  version = "0.18.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "PointDevice";
    repo = "ShootMii";
    #tag = "${version}";
    #branch = "main";
    rev = "6671384f2c1cd8733244da4d5bce9568f1eec37a";
    hash = "sha256-V2sPqwMD/csWNkaJoWmv74OrW3JJsM8LgHdW2Oi0Gmg=";
  };
  patches = [./genericwiimote.patch];

  build-system = [ python313Packages.setuptools ];
  dependencies = with python313Packages; [
    evdev
    pyudev
    pygame
  ];

  #Program does not respond to the '--version' flag and will not work for now

  #nativeCheckInputs = [
  #  versionCheckHook
  #  writableTmpDirAsHomeHook
  #];
  #versionCheckKeepEnvironment = [ "HOME" ];
  #doInstallCheck = true;

  postFixup = ''
    wrapProgram $out/bin/dbar4gun
  '';

  meta = {
    description = "dbar4gun";
    changelog = "https://github.com/PointDevice/ShootMii/releases/tag/${version}";
    homepage = "https://github.com/PointDevice/ShootMii";
    mainProgram = "ShootMii";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      PointDevice
    ];
    platforms = lib.platforms.linux;
  };
}
