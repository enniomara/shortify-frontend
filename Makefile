.PHONY: shell start server build

shell:
	nix-shell --command zsh

start:
	elm-live src/Main.elm -- --debug --output elm.js

server:
	json-server data.js

build:
	elm make src/Main.elm --output dist/elm.js
	cp index.html dist/index.html
