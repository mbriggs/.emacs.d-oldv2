(provide 'init-completion)

(quelpa 'company)

(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay t)


