#!/usr/bin/make -f

tangle:
	emacs --batch \
		--load /usr/local/share/emacs/26.1/lisp/org/ob-tangle.elc \
		--eval '(org-babel-tangle-file "~/.emacs.d/init.org")'
