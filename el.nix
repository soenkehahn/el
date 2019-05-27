{ mkDerivation, base, hpack, process, stdenv, template-haskell }:
mkDerivation {
  pname = "el";
  version = "0.1";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base process template-haskell ];
  preConfigure = "hpack";
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
