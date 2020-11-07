(message "Loading OSX settings...")
;; Intercambiar meta y super en OSX
;(setq mac-command-modifier 'meta)
;(setq mac-option-modifier nil)

;; darwin specific ?
(define-key input-decode-map "\e[1;2A" [S-up])


;; Key modifiers for Mac OS X Emacs.app in spanish MBP keyboard
(global-set-key (kbd "M-1") "|")
(global-set-key (kbd "M-2") "@")
(global-set-key (kbd "M-3") "#")
(global-set-key (kbd "M-º") "\\")
(global-set-key (kbd "M-ç") "}")
(global-set-key (kbd "M-+") "]")
(global-set-key (kbd "M-ñ") "~")
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil) ;; 'super
(global-set-key (kbd "C-+") 'dabbrev-expand)
