{
  description = "purescript-cardano-package-set";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    easy-purescript-nix.url = "github:justinwoo/easy-purescript-nix";
  };

  outputs = { self, nixpkgs, easy-purescript-nix }:
    let
      supportedSystems = [ "x86_64-linux" ];
      perSystem = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      devShells = perSystem (system:
        let
          pkgs = nixpkgsFor system;
          easy-ps = easy-purescript-nix.packages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "purescript-cardano-package-set-shell";
            buildInputs = [
              easy-ps.purs-0_15_8
              easy-ps.spago
            ];
          };
        }
      );
  };
}
