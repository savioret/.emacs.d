

(defun jds-find-tags-file ()
  "recursively searches each parent directory for a file named 'TAGS' and returns the
path to that file or nil if a tags file is not found. Returns nil if the buffer is
not visiting a file"
  (progn
      (defun find-tags-file-r (path)
         "find the tags file from the parent directories"
         (let* ((parent (file-name-directory path))
                (possible-tags-file (concat parent "TAGS")))
           (cond
             ((file-exists-p possible-tags-file) (throw 'found-it possible-tags-file))
             ((string= "/TAGS" possible-tags-file) (error "no tags file found"))
             (t (find-tags-file-r (directory-file-name parent))))))

    (if (buffer-file-name)
        (catch 'found-it
          (find-tags-file-r (buffer-file-name)))
        (error "buffer is not visiting a file"))))

(defun jds-set-tags-file-path ()
  "calls `jds-find-tags-file' to recursively search up the directory tree to find
a file named 'TAGS'. If found, set 'tags-table-list' with that path as an argument
otherwise raises an error."
  (interactive)
  (setq tags-table-list (cons (jds-find-tags-file) tags-table-list)))




(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive "^") ; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(defun ja/string-toggle (s s1 s2)
  (cond
   ((string-match s1 s) (replace-regexp-in-string s1 s2 s))
   ((string-match s2 s) (replace-regexp-in-string s2 s1 s))
   (t s)
   ))

;; (defun ja/toggle-goto()
;;   (interactive)
;;   (setq to (message "d:/hg/%s/" (ido-completing-read
;; 		   "Project: " '("v12"  "v13"  "v13inf"  "v13inf2" "v13aston") nil t)))
;;   (setq from (locate-dominating-file buffer-file-name "TAGS"))
;;   (message "Switched to: %s" to)
;;   (setq new (replace-regexp-in-string from to buffer-file-name))
;;   (find-file new)
;; )

(defun ja/toggle-goto()
  (interactive)
  (let* ((to
		  (message "d:/hg/%s/"
				   (ido-completing-read "Project: "
						  '("all" "all2" "allx" "v12"  "v13"  "v13inf") nil t)))
		 (from (locate-dominating-file buffer-file-name "TAGS"))
		 (new (replace-regexp-in-string from to buffer-file-name))
		 (line (line-number-at-pos))
		 )

	(message "Switching to: %s" new)
	(find-file new)
	(goto-char (point-min))
	(forward-line line)
	)
  )

(defun ja/toggle-version (s)
  (ja/string-toggle
   (ja/string-toggle
	(ja/string-toggle
	 (ja/string-toggle
	  (ja/string-toggle
	   (ja/string-toggle s "/v12/share/presets/modes/videoSetup" "/v13/videoSetup")
	   "/v12/lib/" "/v13/core/")
	  "/v12/plg/v" "/v13/media/")
	 "/v12/rom" "/v13/rom")
	"/v12/wrap" "/v13/wrap")
   "/v12/base" "/v13/base")
)

(defun ja/visit-toggle-file-name-version ()
  (interactive)
  (find-file (message (ja/toggle-version (buffer-file-name)))))

(defun ja/toggle-branch (s)
  (ja/string-toggle
   (ja/string-toggle s "/v12/" "/v12-clean/")
   "/v13/" "/v13-clean/")
  )

(defun ja/visit-toggle-file-name-branch ()
  (interactive)
  (find-file (message (ja/toggle-branch (buffer-file-name)))))

(global-set-key [(f8)] 'ja/visit-toggle-file-name-branch)


(defun ja/toggle-io (s)
  (ja/string-toggle
   (ja/string-toggle s "/plg/vin/" "/plg/vout/")
   "/media/in/" "/media/out/"))


(defun ja/visit-toggle-file-name-io ()
  (interactive)
  (find-file (message (ja/toggle-io (buffer-file-name)))))


(defun ja/set-bsd-style()
  (interactive)
  '(c-set-style "bsd")
  '(setq tab-width 8)
)

(defun ja/set-whitesmith-style()
  (interactive)
  '(c-set-style "whitesmith")
  '(setq tab-width 4)
)

(defun ja/buffer-replace (from to)
  (interactive)
  (goto-char 1)
  (while (search-forward from nil t)
    (replace-match to t nil))
  )

(defun ja/pathtov13 ()
  (interactive)
  (ja/buffer-replace "/plg/v" "/media/")
  (ja/buffer-replace "/lib/" "/core/")
  (ja/buffer-replace "/share/presets/modes/videoSetup/" "/videosetup/")
  )

(defun ja/pathtov12 ()
  (interactive)
  (ja/buffer-replace "/media/out/" "/plg/vout/")
  (ja/buffer-replace "/media/in/" "/plg/vin/")
  (ja/buffer-replace "/media/common/" "/plg/vcommon/")
  (ja/buffer-replace "/core/" "/lib/")
  (ja/buffer-replace "/core/" "/lib/")
  (ja/buffer-replace "/videosetup/" "/share/presets/modes/videoSetup/")
  )


(defun ja/cleandiff ()
  (interactive)
  (execute-kbd-macro
   [?\C-a ?\C-d ?\C-e right]))

;; Keybindings
;; Cambiamos al mismo fichero en otra carpeta
;(global-set-key [(f11)] 'ja/toggle-goto)

;; Cambiamos entre input y output el fichero
;(global-set-key [(f9)] 'ja/visit-toggle-file-name-io)
