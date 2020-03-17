{ pkgs, ... }:

{
  imports = [
    ./go.nix
    ./haskell.nix
    ./python.nix
  ];

  home-manager.users.leniviy = { pkgs, ... }: {
    home.packages = with pkgs; [
    #
      gnumake

    # Node.js
      nodejs

    # Nix
      nixfmt

    # Shell
      shellcheck

    # Rust
      rustup

    # Lisps
      clisp
      sbcl

    # C / C++
      cmake
      clang
      llvm
      rtags
      ccls
    ];
  };
}
