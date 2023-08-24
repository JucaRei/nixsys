#!/bin/sh

# nix-shell -p nixpkgs-fmt --run 'nixpkgs-fmt ./**/*.nix'
nix-shell -p alejandra --run 'alejandra ./**/*.nix'
