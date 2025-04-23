{
  description = "Simple command line tool project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    packages.${system}.default = pkgs.writeShellScriptBin "cowsay-hello" ''
      #!${pkgs.bashInteractive}/bin/bash
      ./cowsay_hello.sh
      '';

    devShells.${system}.default = pkgs.mkShell {
      name = "SimpleCLI";
      buildInputs = [ pkgs.bashInteractive pkgs.jq pkgs.cowsay self.packages.${system}.default];
      shellHook = ''
      export SHELL=${pkgs.bashInteractive}/bin/bash
      echo "Welcome to the Cowsay Project environment!"
      '';
    };
  };
}
