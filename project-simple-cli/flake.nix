{
  description = "Simple command line tool project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/22.11";
  };

  outputs = { self, nixpkgs, nixpkgs-old }:

    let
      system = "x86_64-linux";

      oldpkgs = import nixpkgs-old { inherit system; };

      overlay = final: prev: {
        jq = oldpkgs.jq;
      };
      pkgs = import nixpkgs {
        system = system;
        overlays = [ overlay ];
      };
    in
    {

    overlays.default = overlay;

    packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "cowsay-hello";
        buildInputs = [ pkgs.cowsay ];

        src = ./.;

        installPhase = ''
          cowsay --version || exit 1
          mkdir -p $out/bin/
          cp cowsay_hello.sh $out/bin/cowsay_hello
          chmod +x $out/bin/cowsay_hello
          '';

      };

    devShells.${system}.default = pkgs.mkShell {
      name = "SimpleCLI";
      buildInputs = [ pkgs.bashInteractive pkgs.cowsay pkgs.jq self.packages.${system}.default];
      shellHook = ''
        echo "Welcome to the Cowsay Project environment!"
        echo
      '';
    };
  };
}
