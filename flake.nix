{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    flake-parts.url = github:hercules-ci/flake-parts;
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, ... }: {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "sigbak";

          ## Following the instructions from the README, we need a commit on the
          ## branch `portable`.
          src = pkgs.fetchurl {
            url = "https://github.com/tbvdm/sigbak/archive/62b99fef56f046a9bbccf0291a3e2e714049570f.tar.gz";
            sha256 = "sha256-wwMu1hUN7NfQgSgHtEKlbuj8fzVhbzANUH0TUA4dBJw=";
          };

          buildInputs = with pkgs; [
            protobuf
            protobufc
            sqlite
            openssl
            pkg-config
          ];

          buildPhase = "make";
          installPhase = ''
            mkdir -p $out/bin
            cp sigbak $out/bin/sigbak
          '';
        };
      };
    };
}
