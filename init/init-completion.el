(provide 'init-completion)

(quelpa 'company)

(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load "company"
  '(progn
     (setq company-idle-delay t)

     (defadvice company-pseudo-tooltip-unless-just-one-frontend (around only-show-tooltip-when-invoked activate)
       (when (company-explicit-action-p)
         ad-do-it))))


