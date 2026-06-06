{
  description = "tiddl: CLI Tidal downloader (oskvr37/tiddl), the download backend Tidarr shells out to.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-lib = {
      url = "github:jgus/flake-lib/v1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-lib }:
    flake-lib.lib.mkLeafFlake {
      inherit nixpkgs flake-utils;
      source = { type = "pypi"; pname = "tiddl"; format = "sdist"; };
      package = {
        attr = "tiddl";
        description = "tiddl: CLI Tidal downloader (oskvr37/tiddl), the download backend Tidarr shells out to.";
        kind = "pythonApplication";
        buildSystem = ps: with ps; [ setuptools wheel ];
        dependencies = ps: with ps; [ aiofiles aiohttp m3u8 mutagen pydantic requests requests-cache typer ];
        meta = { mainProgram = "tiddl"; };
        # Upstream pins exact lower bounds we may exceed in nixpkgs; the CLI works fine across them.
        extra = { dontCheckRuntimeDeps = true; };
      };
      pin = import ./pin.nix;
    };
}
