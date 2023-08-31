let
    config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          gen-gitignore =
            haskellPackagesNew.callPackage ./gen-gitignore.nix {
              curl = pkgs.curl;
            };
        };
      };
    };
  };

    pkgs = import <nixpkgs> {inherit config;};
in
  { gen-gitignore = pkgs.haskellPackages.gen-gitignore;
  }
