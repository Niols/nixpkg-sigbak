{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    flake-parts.url = github:hercules-ci/flake-parts;

    ## The README of sigbak recommends following the `portable` branch.
    sigbak = {
      url = github:tbvdm/sigbak/portable;
      flake = false;
    };
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, ... }: {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "sigbak";
          src = inputs.sigbak;

          buildInputs = with pkgs; [
            protobuf
            protobufc
            sqlite
            openssl
            pkg-config
          ];

          buildPhase = "make";
          installPhase = "mkdir -p $out/bin && cp sigbak $out/bin/sigbak";
        };
      };
    };
}
