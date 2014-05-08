(provide 'init-peepopen)
(require 's)

(defun peepopen-goto-file ()
  "Uses external GUI app to quickly jump to a file in the project."
  (interactive)
  (let ((root (projectile-project-root)))
    (when (null root) (error "Not in a project"))

    (shell-command
     (format "open 'peepopen://%s?editor=EmacsClient'"
             (expand-file-name root)))))
