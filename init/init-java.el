(provide 'init-java)

(add-hook 'java-mode-hook 'my-load-eclim)

(defvar *my-eclim-loaded* nil)

(defun my-load-eclim ()
  (when (not *my-eclim-loaded*)
    (message "Loading eclim...")
    (require 'eclim)
    (require 'eclimd)
    (require 'java-syntax-checker)
    (global-eclim-mode)

    (require 'company-emacs-eclim)
    (company-emacs-eclim-setup)

    (message "starting eclimd....")
    (setq eclim-eclipse-dirs '("~/eclipse"))
    (setq eclim-executable "~/eclipse/eclim")
    (start-eclimd "~/Documents/workspace")

    (message "eclim loaded.")
    (setq *my-eclim-loaded* t)))
