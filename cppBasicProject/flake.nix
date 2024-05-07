{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils}:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cmake_tools = pkgs: pkgs.symlinkJoin {
          name = "cmake_tools";
          paths = with pkgs; [
            cmake
            cmake-language-server
            # ninja # used instead of make for speed
            make 
          ];
        };

      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.gcc
            # clang-tools # for autocomplete and other clang thingies
            (cmake_tools pkgs) # adds cmake + autocomplete for CMakeFiles.txt  
          ];
        };
      });
}
