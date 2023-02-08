{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    foundry.url = "github:shazow/foundry.nix";
  };
  outputs = { self, nixpkgs, flake-utils, foundry }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [
	    foundry.overlay
          ];
          pkgs = import nixpkgs {
            inherit system;
            inherit overlays;
          };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.foundry-bin
            ];
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
          };
        }
      );
}
