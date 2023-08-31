{ mkDerivation, base, curl, directory, lib, process }:
mkDerivation {
  pname = "gen-gitignore";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base directory process ];
  executableSystemDepends = [ curl ];
  homepage = "https://github.com/0xmycf/gen-gitignore#readme";
  description = "Generate gitignores from the command line using https://www.toptal.com/developers/gitignore";
  license = lib.licenses.mit;
  mainProgram = "gen-gitignore";
}
