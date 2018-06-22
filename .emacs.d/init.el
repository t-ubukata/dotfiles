;; encoding
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
;; show number
(column-number-mode t)
;; hilight cuosor line
(global-hl-line-mode t)
;; hilight corresponding parenthesis
(show-paren-mode 1)
;; show line number
(line-number-mode 1)
(global-linum-mode)
;; C-k to delete whole line
(setq kill-whole-line t)
;; do not wrap on normal window
(setq-default truncate-lines t)
;; do not wrap in splitted windows
(setq-default truncate-partial-width-windows t)
;; scroll up 1 line
(global-set-key "\M-n" (lambda () (interactive) (scroll-up 1)))
;; scroll down 1 line
(global-set-key "\M-p" (lambda () (interactive) (scroll-down 1)))

;; Scheme mode
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

;; others
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq delete-auto-save-files t)
(setq-default tab-width 2 indent-tabs-mode nil)
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")
(require 'dired-x)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
