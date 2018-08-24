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
                ivy-count-format "(%d/%d) "
                ivy-extra-directories nil)
  :config (ivy-mode t))

(use-package ivy-hydra
  :after ivy)

(use-package counsel
  :after ivy)

(use-package osx-clipboard
  :config (osx-clipboard-mode t))

(use-package gruvbox-theme
  :config (load-theme 'gruvbox t))

(use-package telephone-line
  :config (telephone-line-mode t))

(use-package company
  :config (global-company-mode t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package projectile
  :after  ivy
  :init   (setq projectile-completion-system 'ivy)
  :config (projectile-mode t))

(use-package clojure-mode)

(use-package clj-refactor
  :hook (clojure-mode))

(use-package cider
  :init
  (setq cider-prompt-for-symbol nil
        cider-save-file-on-load t
        cider-font-lock-dynamically '(macro core function var)
        cider-eldoc-display-context-dependent-info t
        cider-repl-pop-to-buffer-on-connect nil
        cider-overlays-use-font-lock t
        cider-pprint-fn "puget")
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-repl-mode-hook #'subword-mode))

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
              display-line-numbers-widen t
              display-line-numbers-width 2
              display-line-numbers-type 'relative)

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
  "B"  'ivy-switch-buffer-other-window
  "s"  'cider-scratch)

;; Show matching parens
(show-paren-mode t)

;; Default indentation
(setq-default indent-tabs-mode nil
              tab-width 2
              c-basic-offset 2)

;; Show trailing whitespace
(setq show-trailing-whitespace 1)

(ivy-set-actions
 'counsel-fzf
 '(("O" find-file-other-window "other window")))

(evil-define-key '(normal visual) clojure-mode-map
  "cc"   'cider-connect
  "cji"  'cider-jack-in
  "crcl" 'clojure-convert-collection-to-list
  "crcm" 'clojure-convert-collection-to-map
  "crcq" 'clojure-convert-collection-to-quoted-list
  "crcs" 'clojure-convert-collection-to-set
  "crcv" 'clojure-convert-collection-to-vector
  "crcp" 'clojure-cycle-privacy
  "crci" 'clojure-cycle-if
  "cril" 'clojure-introduce-let
  "crml" 'clojure-move-to-let
  "crtf" 'clojure-thread-first-all
  "crth" 'clojure-thread
  "crtl" 'clojure-thread-last-all
  "crua" 'clojure-unwind-all
  "cruw" 'clojure-unwind
  "crad" 'cljr-add-declaration
  "crai" 'cljr-add-import-to-ns
  "crar" 'cljr-add-require-to-ns
  "crau" 'cljr-add-use-to-ns
  "crdk" 'cljr-destructure-keys
  "crec" 'cljr-extract-constant
  "cred" 'cljr-extract-def
  "crel" 'cljr-expand-let
  "crfe" 'cljr-create-fn-from-example
  "crmf" 'cljr-move-form
  "crpc" 'cljr-project-clean
  "crpf" 'cljr-promote-function
  "crsc" 'cljr-show-changelog
  "crsp" 'cljr-sort-project-dependencies
  "crsr" 'cljr-stop-referring
  "crup" 'cljr-update-project-dependencies)

(evil-define-key '(normal visual) cider-mode-map
  "clb"  'cider-load-buffer
  "clf"  'cider-load-file
  "claf" 'cider-load-all-files
  "clap" 'cider-load-all-project-ns
  "cram" 'cljr-add-missing-libspec
  "crap" 'cljr-add-project-dependency
  "cras" 'cljr-add-stubs
  "crcn" 'cljr-clean-ns
  "cref" 'cljr-extract-function
  "crfu" 'cljr-find-usages
  "crhd" 'cljr-hotload-dependency
  "cris" 'cljr-inline-symbol
  "crrf" 'cljr-rename-file-or-dir
  "crrl" 'cljr-remove-let
  "crrs" 'cljr-rename-symbol)

(define-clojure-indent
  (future-flow 1)
  (future-facts 1)
  (future-fact 1)
  (flow 1)
  (facts 1)
  (fact 1)
  (as-customer 1)
  (as-delegate 2)
  (as-of 1)
  (assoc-if 1)
  (assoc 1)
  (let-entities 2)
  (constraint-fn 2)
  (provided 0)
  (with-fn-validation 0)
  (system-map 0)
  (tabular 0))
