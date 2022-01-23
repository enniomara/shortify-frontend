.PHONY: shell start server build index

shell:
	nix-shell --command zsh

start: index
	elm-live src/Main.elm --dir dist -- --debug --output dist/elm.js

index:
	test -n "$(SHORTIFY_ENDPOINT)" # env missing
	mkdir -p dist
	sed 's|%API_ENDPOINT%|$(SHORTIFY_ENDPOINT)|' index.html > dist/index.html

server:
	json-server data.js

build: index
	elm make src/Main.elm --output dist/elm.js
