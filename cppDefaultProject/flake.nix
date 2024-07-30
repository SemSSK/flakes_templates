{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {nixpkgs,flake-utils,...}:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {inherit system;};
    in
    {
      devShells = {
        default = pkgs.mkShell {
          name = "cpp Shell";
          buildInputs = with pkgs;[
            just
            pkg-config
            cmake
            cmake-language-server
            ninja
            clang-tools
            gcc
            watchexec
          ];
        };
      };
    });
}
