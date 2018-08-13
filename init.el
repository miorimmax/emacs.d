(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package evil
  :ensure t
  :init   (setq evil-want-integration nil)
  :config (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after  evil
  :config (evil-collection-init))

(use-package evil-surround
  :ensure t
  :after  evil
  :config (global-evil-surround-mode t))

(use-package ivy
  :ensure t
  :config (ivy-mode t))

(use-package counsel
  :after  ivy
  :ensure t)

(use-package gruvbox-theme
  :ensure t
  :config (load-theme 'gruvbox t))

(use-package telephone-line
  :ensure t
  :config (telephone-line-mode t))

(use-package company
  :ensure t
  :config (global-company-mode t))

(use-package rainbow-delimiters
  :ensure t
  :init   (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
  
(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t
  :init   (progn
	    (setq cider-stacktrace-default-filters    '(tooltip dup)
		  cider-repl-pop-to-buffer-on-connect nil
		  cider-repl-use-clojure-font-lock    nil)
	    (add-hook 'clojure-mode-hook 'cider-mode)
	    (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
	    (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)))

(use-package fzf
  :ensure t)

;; Hide unnecessary stuff
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Disable bell
(setq ring-bell-function 'ignore)

;; Disable lock files
(setq create-lockfiles nil)

;; Create temporary files and backups in tmp
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Use y/n prompts instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show line numbers
(global-display-line-numbers-mode t)

;; Highlight current line
(global-hl-line-mode t)

;; Smart tabs (indent or complete)
(setq tab-always-indent 'complete)

;; Ensure new line at EOF
(setq require-final-newline t)

;; Mouse
(unless window-system
  ;; Enable mouse
  (xterm-mouse-mode t)

  ;; Set up scroll wheel
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))

  ;; Enable mouse selection
  (setq mouse-sel-mode t))

;; Write emacs's custom settings to its own file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

;; Disable soft line wrapping
(setq-default truncate-lines 0)

;; Remember last position on files
(save-place-mode t)
