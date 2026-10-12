{
  description = "Automated Miniflux RSS curator using Karakeep relevance signals";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
    in {
      packages = forEachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
          python = pkgs.python313;
          app = python.pkgs.buildPythonApplication {
            pname = "miniflux-curator";
            version = "0.1.0";
            pyproject = true;
            src = self;
            build-system = [ python.pkgs.setuptools ];
            dependencies = with python.pkgs; [ miniflux numpy ];
          };
        in {
          default = app;
          miniflux-curator = app;
        });

      devShells = forEachSystem (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShellNoCC {
            packages = [ pkgs.python313 pkgs.python313Packages.miniflux pkgs.python313Packages.numpy ];
          };
        });
    };
}
