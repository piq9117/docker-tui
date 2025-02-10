{
  description = "Docker TUI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      });
    in
    {
      overlay = final: prev: {
        hsPkgs = prev.haskell.packages.ghc965.override {
          overrides = hfinal: hprev: { 
          openapi3 = prev.haskell.lib.dontCheck (hprev.openapi3.overrideAttrs (oldAttrs: {
            src = builtins.fetchGit {
              url = "git@github.com:alexbiehl/openapi3.git";
              rev = "c2575dfbbf487c8019201ad1abe2d9b49fdc5685";
              ref = "alex/aeson-2-support-for-extensions";
            };
          }));
          };
        };

        tie = final.hsPkgs.callCabal2nix "tie" (builtins.fetchGit {
          url = "git@github.com:piq9117/tie.git";
          rev = "878f1b6b9818ea4f611f807ebcb82f0315d88494";
          ref = "add-media-type";
        }) {};

        generate-api = final.writeScriptBin "generate-api" ''
          GITROOT=$(git rev-parse --show-toplevel)
          rm -rf "$GITROOT/api-lib"
          ${final.tie}/bin/tie --output "$GITROOT/api-lib/docker " \
            --module-name OpenAPI.Docker \
            --package-name openapi-docker \
            "$GITROOT/v1.47.yaml"
        '';

        init-project = final.writeScriptBin "init-project" ''
          ${final.hsPkgs.cabal-install}/bin/cabal init --non-interactive
        '';
      };

      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};

        in {
          generate-api = pkgs.generate-api;
        });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          libs = with pkgs; [
            zlib
            tie
          ];
        in
        {
          default = pkgs.hsPkgs.shellFor {
            packages = hsPkgs: [ ];
            buildInputs = with pkgs; [
              hsPkgs.cabal-install
              hsPkgs.cabal-fmt
              hsPkgs.ghc
              generate-api
              ormolu
              treefmt
              nixpkgs-fmt
              hsPkgs.cabal-fmt
              init-project
            ] ++ libs;
            shellHook = "export PS1='[$PWD]\n❄ '";
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
          };
        });
    };
}
