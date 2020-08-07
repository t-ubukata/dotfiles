;; Encoding.
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
;; Shows line numbers.
(global-linum-mode)
;; Shows a space after each line number.
(setq linum-format "%d ")
;; Hilights the cursor line.
(global-hl-line-mode t)
;; Hilights corresponding parenthesis.
(show-paren-mode 1)
;; Shows the line number on the mode line.
(line-number-mode 1)
;; Shows the column number on the mode line.
(column-number-mode t)
;; C-k to delete whole line.
(setq kill-whole-line t)
;; Not wrap in a normal window.
(setq-default truncate-lines t)
;; Not wrap in a splitted window.
(setq-default truncate-partial-width-windows t)
;; Disables electric indent mode
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))
;; Scheme program name.
(setq scheme-program-name "gosh -i")
;; Separates Custom.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
;; Misc.
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)
(setq-default tab-width 2 indent-tabs-mode nil)
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(menu-bar-mode -1)

;; Key bindings.
;; Scrolls up 1 line.
(global-set-key "\M-n" (lambda () (interactive) (scroll-up 1)))
;; Scrolls down 1 line.
(global-set-key "\M-p" (lambda () (interactive) (scroll-down 1)))
;; C-h to delete backward.
(keyboard-translate ?\C-h ?\C-?)

;; Packages.
(require 'package)
(setq package-check-signature nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
  :config
(use-package undo-tree
  :ensure t
  :defer t
  :init
  (global-undo-tree-mode t)
  (global-set-key (kbd "M-/") 'undo-tree-redo))
  :config
(use-package neotree
  :ensure t
  :defer t
  :config
  (setq neo-show-hidden-files t))
(use-package easy-kill
  :ensure t
  :defer t
  :init
  (global-set-key [remap kill-ring-save] 'easy-kill))

