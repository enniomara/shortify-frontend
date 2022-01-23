.PHONY: shell start server build

shell:
	nix-shell --command zsh

start:
	test -n "$(SHORTIFY_ENDPOINT)" # env missing
	sed 's|%API_ENDPOINT%|$(SHORTIFY_ENDPOINT)|' index.html > dist/index.html
	elm-live src/Main.elm --dir dist -- --debug --output dist/elm.js

server:
	json-server data.js

build:
	test -n "$(SHORTIFY_ENDPOINT)" # env missing
	sed 's|%API_ENDPOINT%|$(SHORTIFY_ENDPOINT)|' index.html > dist/index.html
	elm make src/Main.elm --output dist/elm.js
