(provide 'init-magit)

(quelpa 'magit)
(setq magit-emacsclient-executable "/usr/local/bin/emacsclient")

(global-set-key (kbd "<f1>") 'magit-status)
(define-key evil-normal-state-map "B" 'magit-checkout)


(quelpa 'git-gutter-fringe)
(global-git-gutter-mode)
