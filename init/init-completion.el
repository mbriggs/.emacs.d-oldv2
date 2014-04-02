(provide 'init-completion)

(quelpa 'company)

(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load "company"
                '(lambda ()
                   (setq company-idle-delay t)))

