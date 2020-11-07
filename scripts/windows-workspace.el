(message "Loading windows settings...")

;; we use bb command to compile
(setq compile-command "bb")

;; set c-mode for vertex and fragment shader file extensions
(add-to-list 'auto-mode-alist '("\\.vs\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.fs\\'" . c-mode))

(setq find-program "E:/apps64/msys2-20150512/usr/bin/find.exe")
(setq grep-find-command
   "find . -type f  \\( \\( -path \"./core/*\" -o -path \"./media/*\" -o -path \"./wrap/*\" \\) -a \\( -name \"*.cpp\" -o -name \"*.h\" -o -name \"*.c\" \\) \\) -exec grep -nH --null -e  {} ;")

;;emacs shell to load particular env variables on startup on windows
(setq explicit-cmdproxy.exe-args '("/q /k ~/.emacs_cmdproxy.bat"))

;; clang-format
(use-package clang-format
  :config
  (add-hook 'c-mode-hook
            (lambda () (add-hook 'before-save-hook #'clang-format-buffer nil t)))
  (add-hook 'c++-mode-hook
            (lambda () (add-hook 'before-save-hook #'clang-format-buffer nil t)))
  (setq clang-format-executable "D:/hg/apps64/clang-format.exe")
  )

;; auto delete trailing spaces on save
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

;; Automatic tag file generation for c/c++ files
(defun create-c-tags (dir-name)
     "Create tags file."
     (interactive "DDirectory: ")
     (eshell-command
	  (format "find . -type f \( -name \"*.[ch]\" -o -name \"*.[ch]pp\" -o -name \"*.py\" \) \( -path \"./core/*\" -o -path \"./media/*\" -o -path \"./base/*\" -o -path \"./aw/*\" -o -path \"./videosetup/*\" -o -path \"./wrap/*\" \) -a -not -path \"*/.hg/*\" | etags -" dir-name)))

;; Custom folder code


(setq etags-table-alist
	  (list
	   '("d:/hg/v12/.*$" "d:/hg/v12/TAGS")
	   '("d:/hg/v13aston/.*$" "d:/hg/v13aston/TAGS")
	   '("d:/hg/all/.*$" "d:/hg/all/TAGS")
	   '("d:/hg/allx/.*$" "d:/hg/allx/TAGS")
	   '("d:/hg/all2/.*$" "d:/hg/all2/TAGS")
	   ))

;; filecache module directories

;; (file-cache-add-directory-recursively "e:\\hg\\v12\\plg" "\\(.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v12\\lib" "\\(.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v12\\base" "\\(.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v12\\wrap" "\\(.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v12\\share\\presets\\modes\\videoSetup" "\\(.*\\.\\(py\\)$\\)")
;; forzamos inicio con alphanumeric para evitar .hg en subrepos
;; (file-cache-add-directory-recursively "e:\\hg\\v13\\core" "\\(\\w.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v13\\media" "\\(\\w.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v13\\base" "\\(\\w.*\\.\\(cpp\\|c\\|h\\)\\|.*Scons.*$\\)")
;; (file-cache-add-directory-recursively "e:\\hg\\v13\\videosetup" "\\(\\w.*\\.\\(py\\)$\\)")

