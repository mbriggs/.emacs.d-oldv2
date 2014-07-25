(provide 'init-shell)

(add-hook 'eshell-mode-hook
          (lambda ()
            (setenv "TERM" "emacs"))) ; enable colors
