{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, naersk, nixpkgs, utils, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
      let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs { inherit system overlays; };
        naerskLib = pkgs.callPackage naersk {};
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
        devShell = with pkgs; mkShell {
          buildInputs = [
            rust
            cargo-tauri
            udev
            mold
          ] ++ packages;
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          
          shellHook =
            ''
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
            '';

      });
}
