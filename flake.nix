{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let
      helloOverlay = final: prev: {
        hello1 = prev.hello;
      };
    in
    utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ helloOverlay ]; };
        in
        {
          legacyPackages = pkgs;
        }
      ) //
    # overlays have to be outside of eachSystem block
    { overlays.default = helloOverlay; };
}
