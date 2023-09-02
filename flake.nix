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
          npmDepsHash = "sha256-K30UsMZ508XT1x/1eXY/xg7dfhLm55pdi9vOdDQHtWg=";
          npmBuild = "npm run build";
          installPhase = ''
            mkdir $out
            cp -r dist/* $out
          '';
        };
      });
    };
}
