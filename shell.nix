{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [
        pkgs.elmPackages.elm-live
        pkgs.elmPackages.elm
        pkgs.elmPackages.elm-test

        pkgs.nodePackages.json-server
    ];
}
