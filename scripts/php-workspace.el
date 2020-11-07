;; ---- PHP MODE ----
;; (require 'php-mode)
;; (add-hook 'php-mode-hook 'php-enable-drupal-coding-style)
;; ;(add-hook 'php-mode-hook 'php-enable-wordpress-coding-style)
;; (add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
;; (add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))


(defun create-php-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (async-shell-command 
   (format "cd %s; find . -type f \\( -name '*.php' -o -name '*.inc' -o -name '*.module' \\) -not -path '*/.hg/*' -a -not -path './docs/*' -a -not -path './images/*'  -a -not -path './tmp/*' -a -not -path './files/*'  -a -not -path './.svn/*' -a -not -path './sites/all/libraries/*' | etags --language=php -" dir-name))
  (eshell-command 
   (format "cd %s; find . -type f \\( -name '*.info' -o -name '*.js' -o -name '*.css' \\) -not -path '*/.hg/*' -a -not -path './docs/*' -a -not -path './images/*'  -a -not -path './tmp/*' -a -not -path './files/*'  -a -not -path './.svn/*' -a -not -path './sites/all/libraries/*' | etags -a -" dir-name))
  )
