(provide 'init-completion)

(quelpa 'company)

(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load "company"
  '(progn
     (setq company-auto-complete t)
     (setq company-idle-delay t)))

