{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        helloOverlay = _: super: {
          hello1 = super.hello;
        };
        pkgs = import nixpkgs { inherit system; overlays = [ helloOverlay ]; };
      in
      {
        legacyPackages = pkgs;
      }
    );
}
