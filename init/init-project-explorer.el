(provide 'init-project-explorer)

(quelpa 'project-explorer)

(global-set-key (kbd "<f2>") 'project-explorer-open)

(add-hook 'project-explorer-mode-hook '(lambda ()
                                         (evil-emacs-state 1)))
