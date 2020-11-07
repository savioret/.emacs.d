;; Use ido to list tags, but then select via etags-select (best of both worlds!)
(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapc (lambda (x)
                (push (prin1-to-string x t) tag-names))
              tags-completion-table
	      )
    (etags-select-find (ido-completing-read "Tag: " tag-names))))

  ;; This isn't necessary, but I thought it helpful as a reminder to refresh if the cache isn't initialized

