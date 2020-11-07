;; typed from http://www.vimeo.com/1013263
(require 'etags-table)

(defun ido-find-file-in-tags ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
	  (setq tags-file-name nil)
	  ;;(etags-table-recompute)
      (visit-tags-table-buffer)
	  )
    (find-file
     (ido-completing-read "Project file: "
                          (tags-table-files)
                          nil t))))

(provide 'ido-find-file-in-tags)
