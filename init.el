(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package evil
  :init   (setq evil-want-integration nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after  evil
  :config (evil-collection-init))

(use-package evil-surround
  :after  evil
  :config (global-evil-surround-mode t))

(use-package evil-leader
  :after  evil
  :config (global-evil-leader-mode))

(use-package ivy
  :init   (setq ivy-use-virtual-buffers t
                ivy-count-format        "(%d/%d) "
                ivy-extra-directories   nil)
  :config (ivy-mode t))

(use-package counsel
  :after  ivy)

(use-package osx-clipboard
  :config (osx-clipboard-mode t))

(use-package gruvbox-theme
  :config (load-theme 'gruvbox t))

(use-package telephone-line
  :config (telephone-line-mode t))

(use-package company
  :config (global-company-mode t))

(use-package rainbow-delimiters
  :init   (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package projectile
  :after  ivy
  :init   (setq projectile-completion-system 'ivy)
  :config (projectile-mode t))

(use-package clojure-mode)

(use-package cider
  :init   (lambda (x)
            (setq cider-stacktrace-default-filters    '(tooltip dup)
                  cider-repl-pop-to-buffer-on-connect nil
                  cider-repl-use-clojure-font-lock    nil
                  cider-font-lock-dynamically         '(macro core function var)
                  cider-prompt-for-symbol             nil)
            (add-hook 'clojure-mode-hook 'cider-mode)
            (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
            (add-hook 'cider-repl-mode-hook #'eldoc-mode)
            (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)))

(use-package ensime)

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

;; Disable backup files
(setq make-backup-files nil)

;; Use y/n prompts instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show line numbers
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-grow-only t
              display-line-numbers-widen     t
              display-line-numbers-width     2
              display-line-numbers-type      'relative)

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

;; Leader key
(evil-leader/set-leader ",")

(evil-leader/set-key
  "mx" 'counsel-M-x
  "o"  'counsel-fzf
  "f"  'counsel-ag
  "r"  'counsel-recentf
  "b"  'ivy-switch-buffer
  "B"  'ivy-switch-buffer-other-window)

;; Show matching parens
(show-paren-mode t)

;; Show doc in minibuffer
(global-eldoc-mode t)

;; Default indentation
(setq-default indent-tabs-mode nil
              tab-width 2
              c-basic-offset 2)

;; Show trailing whitespace
(setq show-trailing-whitespace 1)

(ivy-set-actions
 'counsel-fzf
 '(("O" find-file-other-window "other window")))
