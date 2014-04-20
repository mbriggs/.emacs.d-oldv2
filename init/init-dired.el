(provide 'init-dired)

(quelpa 'dired+)
(require 'dired+)

(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "gls")
(setq wdired-allow-to-change-permissions t)
(define-key dired-mode-map (kbd "M-e") 'wdired-change-to-wdired-mode)
