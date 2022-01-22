.PHONY: shell start server

shell:
	nix-shell --command zsh

start:
	elm-live src/Main.elm -- --debug --output elm.js

server:
	json-server data.js
