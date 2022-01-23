.PHONY: shell start server build

shell:
	nix-shell --command zsh

start:
	cp index.html dist/index.html
	elm-live src/Main.elm --dir dist -- --debug --output dist/elm.js

server:
	json-server data.js

build:
	elm make src/Main.elm --output dist/elm.js
	cp index.html dist/index.html
