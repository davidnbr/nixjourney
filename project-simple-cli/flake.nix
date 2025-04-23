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
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [ pkgs.bashInteractive pkgs.jq pkgs.cowsay self.packages.${system}.default];
      shellHook = ''echo "Welcome to the Cowsay Project environment!"'';
    };
    packages.${system}.default = pkgs.writeShellScriptBin "cowsay-hello" ''
      #!${pkgs.bashInteractive}/bin/bash
      ./cowsay_hello.sh
      '';
  };
}
