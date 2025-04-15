{
  description = "Very basic Nix flake";

  outputs = {self}: {
      hello = "Hello, Nix!";
    };
}

# run: nix flake show .
# to print: nix eval .#hello
