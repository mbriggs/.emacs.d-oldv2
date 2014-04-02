(provide 'init-projectile)

(quelpa 'projectile)
(quelpa 'grizzl)

(projectile-global-mode)

(global-set-key (kbd "M-t") 'projectile-find-file)
(global-set-key (kbd "M-W") 'projectile-kill-buffers)
(global-set-key (kbd "<f5>") 'projectile-regenerate-tags)

(setq projectile-completion-system 'grizzl)
