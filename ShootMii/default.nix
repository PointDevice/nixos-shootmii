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
  #version = "0.18.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "PointDevice";
    repo = "ShootMii";
    #tag = "${version}";
    branch = "main";
    hash = "sha256-82OIzIammz5EuDcsWRzhevfuXQMRRYJ5nsXWTx+Pnis=";
  };

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
