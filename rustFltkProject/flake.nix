{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = { self, nixpkgs, utils, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
      let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs { inherit system overlays; };
        rust = pkgs.rust-bin.stable.latest.default.override {
                extensions = [
                  "rust-analyzer"
                ];
              };
        libraries = with pkgs; [
          fltk
          pango
          libGL
          libxkbcommon
          wayland
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr
          xorg.libXext
          xorg.libXinerama
          xorg.libXrender
          xorg.libXfixes
          xorg.libXft
          fontconfig
        ];
        libPath = pkgs.lib.makeLibraryPath libraries;
      in
      {
        devShell =  pkgs.mkShell {
          buildInputs = [
            rust
            pkgs.pkg-config
            pkgs.udev
            pkgs.mold
            pkgs.gcc
            pkgs.cmake
          ];
          RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
          LD_LIBRARY_PATH = libPath;
        };
      });
}
