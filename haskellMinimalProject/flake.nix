{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils}:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        haskell = pkgs.haskellPackages.ghcWithPackages (pkgs: with pkgs; [ cabal-install ])
      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            haskell
          ];
        };
      });
}
