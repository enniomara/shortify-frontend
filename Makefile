.PHONY: shell start

shell:
	nix-shell --command zsh

start:
	elm-live src/Main.elm -- --debug
