{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/3590f02e7d5760e52072c1a729ee2250b5560746.tar.gz") {}}:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [
        pkgs.elmPackages.elm-live
        pkgs.elmPackages.elm
        pkgs.elmPackages.elm-test

        pkgs.nodePackages.json-server
    ];
}
