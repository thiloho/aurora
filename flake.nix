{
  description = "JavaScript development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      packages = forAllSystems ({ pkgs }: {
        default = pkgs.buildNpmPackage {
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
      });
    };
}
