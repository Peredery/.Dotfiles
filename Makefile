SHELL := /bin/bash

ubuntu-deps:
	sudo apt update
	sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev curl git neovim zsh

asdf-intall:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

asdf-plugins:
	. ~/.asdf/asdf.sh
	. ~/.asdf/completions/asdf.bash
	asdf plugin add ruby
	asdf plugin add python
	asdf plugin add nodejs
	asdf install ruby latest
	asdf install python latest
	asdf install nodejs latest
	asdf global ruby latest
	asdf global python latest
	asdf global nodejs latest

