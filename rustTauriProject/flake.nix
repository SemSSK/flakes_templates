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
        libraries = with pkgs;[
          webkitgtk
          gtk3
          cairo
          gdk-pixbuf
          glib
          dbus
          openssl_3
          librsvg
          zlib
          pango
          harfbuzz
          atk
          libsoup
        ];

        packages = with pkgs; [
          gcc
          curl
          wget
          pkg-config
          dbus
          openssl_3
          glib
          gtk3
          webkitgtk
          librsvg
        ];

      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            rust
            pkgs.cargo-tauri
            pkgs.udev
            pkgs.mold
          ] ++ packages;
          RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
          
          shellHook =
            ''
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
            '';

      });
}
