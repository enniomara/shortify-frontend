.PHONY: shell start server

shell:
	nix-shell --command zsh

start:
	elm-live src/Main.elm -- --debug

server:
	json-server data.js
