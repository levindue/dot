;; -*- lexical-binding: t -*-

;; Better Defaults

(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq ring-bell-function 'ignore)

(setq scroll-step 1)
(setq scroll-conservatively 101)
(setq pixel-scroll-precision-mode t)
(setq pixel-scroll-precision-use-momentum nil)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-default-style "bsd")
(setq c-basic-offset 4)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defalias 'yes-or-no-p 'y-or-n-p)

;; custom file

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))

;; Options

(setq-default frame-title-format '("Emacs"))
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(electric-pair-mode 1)
(column-number-mode 1)

(setq make-backup-files nil)
(setq auto-save-default nil)

(set-frame-font "Iosevka Nerd Font 18" nil t)

;; Keybinds

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x b") 'consult-buffer)

(global-set-key (kbd "M-M") 'compile)
(global-set-key (kbd "M-m") 'recompile)

;; Packages

(require 'package)
(package-initialize)

(with-eval-after-load 'package
  (setq package-archives
        '(("gnu" . "http://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
          ("melpa" . "https://melpa.org/packages/"))))

(require 'use-package)
(setq use-package-always-ensure t)

;; Themes

(use-package gruber-darker-theme)
(use-package ef-themes)

;; Git

(use-package magit)

;; Minibuffer

(use-package vertico
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

(use-package consult)

;; completion

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package corfu
  :init
  (global-corfu-mode))

;; languages

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git"
            :rev :newest))

(use-package odin-mode
  :vc (:url "https://git.sr.ht/~mgmarlow/odin-mode"
            :rev :newest))

(use-package haskell-mode)

(let ((my-ghcup-path (expand-file-name "~/.ghcup/bin")))
  (setenv "PATH" (concat my-ghcup-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-ghcup-path))

(use-package rust-mode
  :custom
  (rust-indent-offset 4))

(use-package julia-mode)
(use-package zig-mode)
