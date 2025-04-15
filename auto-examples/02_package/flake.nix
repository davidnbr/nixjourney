{
  description = "A flake packaging GNU Hello";

  # inputs add the dependencies of the flake
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # outputs take inputs as arguments
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      # import nixpkgs for the system specified
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {
      # 'packages' is a std output attribute set for packages
      packages.${system} = {
        hello = pkgs.hello;

        # default package is what 'nix build' or 'nix run' uses if no specific package is named
        default = self.packages.${system}.hello;
      };
    };
}
