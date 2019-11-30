{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  # Python
    (python37.withPackages(ps: with ps;
      [ pip virtualenvwrapper conda # Env
        attrs requests urllib3 django_2_2 pynvim
        pytest nose                  # Tests
        black                         # Formatter 
        python-language-server
        pyls-black pyls-isort pyls-mypy
        grip                          # Grip -- GitHub Readme Instant Preview
      ]
    ))
   
  # Golang
    go

  # Haskell
    (haskellPackages.ghcWithPackages(ps: with ps;
      [ cabal-install stack hoogle] # ghc-mod 
    ))
   
  # Rust
    rustup
  ];

  # Golang
  environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
}
