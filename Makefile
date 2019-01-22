#!/usr/bin/make -f

VERSION := $(shell brew info emacs-plus --json=v1 | \
	jq -r '.[] | select(.name == "emacs-plus") | .installed | first | .version' | \
	sed 's/\(\d+\.\d+\).*/\1/g')

.PHONY: all
all: tangle restart

.PHONY: tangle
tangle:
	emacs --batch \
		--load /usr/local/share/emacs/${VERSION}/lisp/org/ob-tangle.elc \
		--eval '(org-babel-tangle-file "~/.emacs.d/init.org")'

.PHONY: restart
restart:
	brew services restart emacs-plus
