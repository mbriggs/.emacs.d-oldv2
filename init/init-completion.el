(provide 'init-completion)

(quelpa 'company)

(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load "company"
  '(progn
     (define-key company-active-map (kbd "<tab>") nil)
     (define-key company-active-map (kbd "ESC") 'company-abort)
     (define-key company-active-map (kbd "<C-return>") 'company-abort)

     (setq company-idle-delay 0)
     (setq company-minimum-prefix-length 3)
     (setq company-dabbrev-downcase nil)
     (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                               company-preview-frontend
                               company-echo-metadata-frontend))


     (defadvice company-pseudo-tooltip-unless-just-one-frontend (around only-show-tooltip-when-invoked activate)
       (when (company-explicit-action-p)
         ad-do-it))))
