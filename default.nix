{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
     buildInputs = (with pkgs.python3Packages; [ pylint pandas numpy pyfzf beautifulsoup4 psycopg2 sqlalchemy ]);
  }
