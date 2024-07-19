{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
     buildInputs = (with pkgs.python3Packages; [ pandas numpy pyfzf beautifulsoup4 psycopg2 sqlalchemy ]);
  }
