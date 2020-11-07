;; enhace load time
(setq gc-cons-threshold 100000000)

(add-to-list 'load-path "~/.emacs.d/scripts")
; (add-to-list 'load-path "~/.emacs.d/flx-master")
; (require 'flx-ido)
; (flx-ido-mode 1)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-input-method 'spanish-prefix)

;; Shows current function's name (which-func.el)
;; Beware of performace with large files !!!
(which-function-mode 0)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; See full file path in title bar
(setq frame-title-format
      (list '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; blink paren match
;; (blink-matching-paren t) ;; enable paren matching
;; (setq blink-matching-paren-on-screen t)
(show-paren-mode t)
(delete-selection-mode 1)
(defvar compilation-scroll-output t)
(column-number-mode t)

;; Force ibuffer list as default
(defalias 'list-buffers 'ibuffer)

;; spaces instead of tabs
(defvar c-tab-always-indent t)
(defvar c-basic-offset 4)
(defvar default-tab-width 4)
(defvar c-default-style "whitesmith")

(add-hook 'python-mode-hook
	  (lambda()
	    (setq indent-tabs-mode t)
	    (setq tab-width 8)
	    (setq python-indent 8)))

;; Disable the need of parenthesis escaping in en re-builder
(defvar reb-re-syntax 'string)

;; Duplicar una seleccion
(load "duplicate.el")

;; Open file in explorer/finder
(load "fileopen.el")

;; inverse of pop operation
(load "unpop-mark.el")

;; move line up and down
(load "move-line.el")

;; Custom commands to jump over folders
(load "switchver.el")

;;(load "php-workspace.el")

;; Disable version control  integration to speed up
;(setq vc-handled-backends nil)

;;;;;;;;;;;;;;;;;;; PACKAGES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; external package initialize
(load "packages.el")

;; use-page auto installation
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

;; ----------------------------------------------------------------
;; Uncomment this block first time emacs runs this configuration !!!
;; After all packages install, re-comment
;; ----------------------------------------------------------------
;(eval-when-compile
;  (require 'use-package)
;  (setq use-package-always-ensure t)
;  )

;; local packages
(require 'redo+)

;; (require 'swbuff)
;; (global-set-key [C-tab] 'swbuff-switch-to-next-buffer)
;; (global-set-key [C-S-tab] 'swbuff-switch-to-previous-buffer)

;; Rename buffers with the same name
(require 'uniquify)

(setq uniquify-buffer-name-style 'forward)
;; (setq
;;  uniquify-buffer-name-style 'reverse
;;  uniquify-separator ":")

(use-package cycbuf
  :config
	(cycbuf-init)
	(custom-set-faces
	 '(cycbuf-current-face ((t (:background "dark green")))))
	(setq cycbuf-clear-delay 1)
	'(cycbuf-buffer-sort-function 'cycbuf-sort-by-recency)
  :bind(
       ([C-tab] . cycbuf-switch-to-next-buffer)
       ([C-S-tab] . cycbuf-switch-to-previous-buffer)
       )
  )

(use-package ido-vertical-mode
  :disabled
  :config
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
)

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Jump to cursor definition. Bound to C-M-i
(use-package ido-at-point
  :config (ido-at-point-mode)
  )

;; Number the isearch lines and some useful replacement functions
(use-package anzu
  :config (global-anzu-mode +1)
  )

(use-package grep-a-lot)

(use-package expand-region)

(use-package flex-isearch
  :config
  (turn-on-flex-isearch)
  ;(setq flex-isearch-mode 1)
  )

;; Shell command autocomplete
;; (require 'shell-command)
;; (autoload 'bash-completion-dynamic-completev
;;   "bash-completion"
;;   "BASH completion hook")
;; (add-hook 'shell-dynamic-complete-functions
;;           'bash-completion-dynamic-complete)
;; (add-hook 'shell-command-complete-functions
;;           'bash-completion-dynamic-complete)

;;ido-mode
(use-package ido
  :config
  (setq ido-enable-flex-matching t) ;; enable fuzzy matching
  (setq ido-everywhere t)
  (setq ido-max-work-directory-list 50)
  (setq ido-max-work-file-list 120)
  (setq ido-enable-last-directory-history t)
  (ido-mode t)
  ;; agregar a ido lo que haya en filecache
  (load "ido-filecache.el")
)


;; ido mode for M-x command execution
(use-package smex
  :config
  (smex-initialize)
  ; smex ido-mode command history
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  )

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1)
  :requires smex
  )

(use-package regex-tool)

;; jump to local(buffer) functions using ido
(use-package idomenu
  :config (load "ido-goto.el")
  )

(use-package recentf
  :config
  (recentf-mode t)
  (setq recentf-max-saved-items 100)
)

(use-package fiplr
  :config
  (fiplr-mode t)
  (setq fiplr-ignored-globs
	'((directories (".git" ".svn" ".hg" ".bzr" "b" "build" "x64"))
	  (files (".#*" "*~" "*.so" "*.jpg" "*.png" "*.gif" "*.pdf" "*.gz" "*.zip"))
	  ))
  )

;; Sets the tags table based on current file
(use-package etags-table
  :config
  (setq etags-table-search-up-depth 20)
  (require 'ido-find-file-in-tags)
  ;; Busqueda fuzzy brutal de un fichero buscando su root (usar con cuidado)
  ;;(global-set-key (kbd "C-M-o") 'fiplr-find-file)
  ;; Lo mas similar al sublime text para saltar a fichero del proyecto
  ;; Warning ! This shortcut does not work in some terminals
  (global-set-key (kbd "M-O") 'ido-find-file-in-tags)
  )

;; Choose between a list of tags with the same name
(use-package etags-select
  :config
  ;; finding a tag using etags selection
  (load "my-ido-find-tag.el")
  ;; Lo mas similar al sublime text para saltar a un simbolo
  ;(global-set-key (kbd "C-M-O") 'etags-select-find-tag)
  ;; Parece que no funciona en terminal
  (global-set-key (kbd "C-M-O") 'my-ido-find-tag)
  )

(use-package ace-jump-mode
  :disabled
  )


;; inline autocomplete using etags
(use-package ac-etags
  :config
  (ac-config-default)
  (ac-etags-setup)
  (setq ac-etags-requires 2)
)


(use-package whitespace
  :config
  ;;(setq whitespace-style '(trailing face tabs lines-tail))
  ;;(setq whitespace-style '(trailing face lines-tail))
  ;; compatibilidad con fill-column-indicator
  (setq whitespace-style '(face trailing))
  )

(use-package auto-highlight-symbol
  :disabled
  :config
     (global-auto-highlight-symbol-mode t))

(defun enable-whitespace-mode ()
  (whitespace-mode 1))
(add-hook 'prog-mode-hook 'enable-whitespace-mode)

(defvar modes-where-I-want-whitespace-mode-to-be-enabled
      '(c-mode-hook
	c++-mode-hook
       javascript-mode-hook
	python-mode-hook
        js-mode-hook
        css-mode-hook
        nxhtml-mode-hook))

(mapc (lambda (mode-hook)
        (add-hook mode-hook 'enable-whitespace-mode))
      modes-where-I-want-whitespace-mode-to-be-enabled)


(use-package nyan-mode
  :config
  (nyan-mode 1)
  (setq nyan-animate-nyancat t)
  (setq nyan-animate-nyancat t)
)

;; File caching
(use-package filecache)

(use-package flycheck
  :config
  :disabled
  ;(load "typescript.el")
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (global-flycheck-mode)
  )

(use-package elscreen
  :disabled
  :config
  (elscreen-start)
  )

(use-package which-key
  :config
  (which-key-mode))

(use-package restart-emacs)

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-S-l") 'mc/edit-lines)
  (global-set-key (kbd "M-S-l") 'mc/mark-all-like-this)
  )

(use-package fill-column-indicator
  :config
  (setq fci-rule-column 80)
  (add-hook 'c-mode-hook 'fci-mode)
  (add-hook 'c++-mode-hook 'fci-mode)
  (add-hook 'python-mode-hook 'fci-mode)
  )

(use-package rainbow-delimiters
  :config
  (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))
 )

(use-package path-headerline-mode
  :config
  (path-headerline-mode +1)
  )

;; Colors in dired files
(use-package diredfl
  :disabled
  :config
  (diredfl-global-mode)
  )

(use-package buffer-move
  :config
  (global-set-key (kbd "<C-S-up>")     'buf-move-up)
  (global-set-key (kbd "<C-S-down>")   'buf-move-down)
  (global-set-key (kbd "<C-S-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-right>")  'buf-move-right)
  ;;(setq buffer-move-behavior 'move)
  )

;;;;;;;;;;;;; KEYBINDINGS ;;;;;;;;;;;;;;;;;

;; Jump to a local symbol using IDO
(global-set-key (kbd "M-P") 'ido-goto-symbol)

;; Show la list of local symbols (tambien C-c TAB)
(global-set-key (kbd "C-c C-i") 'imenu)

;; Same as C-x C-f but adding cached files of file-cache
(global-set-key (kbd "C-c C-f") 'jcl-file-cache-ido-find-file)

;; Show a raw list of recently opened files
(global-set-key (kbd "C-c C-o") 'recentf-open-files)

;; Jump to symbol where cursor is over
(global-set-key (kbd "M-.") 'etags-select-find-tag-at-point)

;; Jump to symbol in new window where cursor is over
(global-set-key (kbd "M-C-.") 'xref-find-definitions-other-window)

;; Line or region duplication
(global-set-key (kbd "M-C-d") 'duplicate-start-of-line-or-region)

;; Switch between header and source of a file
(global-set-key [f12] 'ff-find-other-file)

# Change coding style
(global-set-key (kbd "C-c 1") 'ja/set-bsd-style)
(global-set-key (kbd "C-c 2") 'ja/set-whitesmith-style)

;; An autocomplete simpler than dabbrev-expand
(global-set-key (kbd "C-+") 'hippie-expand)
;(global-set-key (kbd "M-+") 'dabbrev-expand)
;(global-set-key (kbd "C-+") 'dabbrev-expand)

; Ir al principio del linea, igual que Visual Studio
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

;(global-set-key (kbd "M-p") 'ido-find-file-in-tags)

; Expand the selection at cursor incrementally
(global-set-key (kbd "C-'") 'er/expand-region)

; Delete only first character of the line
(global-set-key (kbd "<M-f1>") 'ja/cleandiff)

; Jump to previous and next buffer
(global-set-key (kbd "<C-prior>") 'previous-buffer)
(global-set-key (kbd "<C-next>") 'next-buffer)

;; Explicit undo key binding (necessary for Linux)
(global-set-key (kbd "C-_") 'undo)

(global-set-key (kbd "C-M-_") 'redo+)

; ace jump mode - Bound to "¿¡" key
(global-set-key [?\C-\241] 'ace-jump-mode)

(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "<C-up>") 'scroll-down-line)
(global-set-key (kbd "<C-down>") 'scroll-up-line)

(global-set-key (kbd "<M-left>") 'smart-beginning-of-line)
(global-set-key (kbd "<M-right>") 'move-end-of-line)

;; (global-set-key (kbd "<C-M-left>") 'pop-to-mark-command)
;; (global-set-key (kbd "<C-M-right>") 'unpop-to-mark-command)

;; M-S-2 Show current file/folder in dired
(global-set-key (kbd "M-\"") 'dired-jump-other-window)
;(global-set-key (kbd "M-S-2") 'dired-jump-other-window)

; Switch to same file in other folder (custom command)
(global-set-key [(f11)] 'ja/toggle-goto)

(cond
 ((eq system-type 'windows-nt) (load "windows-workspace.el"))
 ((eq system-type 'darwin) (load "darwin-workspace.el"))
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight normal :height 110 :foundry "outline" :family "Hack" :antialias subpixel))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))
;;:family "DejaVu Sans Mono"
;;:family "CentSchbook Mono BT"
;;:family "Droid Sans Mono"
;;:family "LM Mono 10"
;;:family "Anonymous Pro"
;;:family "Courier New"

;; ---- SPECIAL COMMANDS -----
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;(server-force-delete)
(require 'server)
(unless (server-running-p)
  (server-start))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(beacon-color "#cc6666")
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(package-selected-packages
   (quote
    (lsp-mode monokai-theme buffer-move diredfl path-headerline-mode markdown-mode multiple-cursors auto-highlight-symbol fill-column-indicator restart-emacs rainbow-delimiters smartparens which-key elscreen nyan-mode ido-completing-read+ grizzl use-package ac-etags web-mode tide typescript-mode swbuff sr-speedbar smex shell-command regex-tool projectile php-mode imenu-anywhere idomenu ido-vertical-mode ido-ubiquitous ido-at-point grep-a-lot flx-ido flex-isearch fiplr expand-region etags-table etags-select ctags-update color-theme-sanityinc-tomorrow color-theme clang-format bash-completion badger-theme anzu ample-zen-theme ample-theme alect-themes ag ace-jump-buffer))))

;; ---- THEME ----
(use-package color-theme-sanityinc-tomorrow
  :config
  (color-theme-sanityinc-tomorrow-night)
)
;; (load-theme 'ample)
