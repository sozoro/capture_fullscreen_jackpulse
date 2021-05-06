{ pkgs ? import <nixpkgs> {} }:
let
  ffmpeg = pkgs.ffmpeg-full;
in
  pkgs.mkShell {
    nativeBuildInputs = [
      (pkgs.callPackage ./default.nix { ffmpeg = ffmpeg; })
    ];
  }
