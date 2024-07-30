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
        libPath = pkgs.lib.makeLibraryPath (with pkgs; [
          libGL
          libxkbcommon
          wayland
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr
        ]);
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            rust
            pkgs.pkg-config
            pkgs.bacon
            pkgs.udev
            pkgs.mold
          ];
          RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
          LD_LIBRARY_PATH = libPath;
        };
      });
}
