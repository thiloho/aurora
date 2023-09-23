{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs_20
        tree
      ];
    };
    packages.${system}.default = pkgs.buildNpmPackage {
      name = "build-aurora-blog";
      buildInputs = with pkgs; [
        nodejs_20
      ];
      src = ./.;
      npmDepsHash = "sha256-hIfaaeKbS+Whav575OyIX1c9GoL6qks12zhHZB2w9IA=";
      npmBuild = "npm run build";
      installPhase = ''
        mkdir $out
        cp -r dist/* $out
      '';
    };
  };
}
