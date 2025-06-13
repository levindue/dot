
(setq-default frame-title-format '("Emacs"))
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq ring-bell-function 'ignore)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq scroll-step 1)
(setq scroll-conservatively 101)
(setq pixel-scroll-precision-mode t)
(setq pixel-scroll-precision-use-momentum nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-default-style "bsd") 
(setq c-basic-offset 4)

(electric-pair-mode 1)
(column-number-mode 1)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))

(set-frame-font "JetBrainsMono 14" nil t)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x b") 'consult-buffer)

(global-set-key (kbd "M-M") 'compile)
(global-set-key (kbd "M-m") 'recompile)

(require 'package)
(package-initialize)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(use-package gruber-darker-theme
  :ensure t)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

(use-package vertico-flat
  :after vertico
  :ensure nil
  :init
  (vertico-flat-mode 1))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package consult
  :ensure t)

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

(setq treesit-language-source-alist
      '((ocaml "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "grammars/ocaml/src/")
        (ocaml-interface "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "grammars/interface/src/")))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git" 
            :rev :newest))

(use-package odin-mode
  :vc (:url "https://git.sr.ht/~mgmarlow/odin-mode"
            :rev :newest))

(use-package haskell-mode
  :ensure t)

(let ((my-ghcup-path (expand-file-name "~/.ghcup/bin")))
  (setenv "PATH" (concat my-ghcup-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-ghcup-path))

(use-package rust-mode
  :ensure t)
