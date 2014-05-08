(provide 'init-projectile)

(quelpa 'projectile)
(quelpa 'grizzl)

(projectile-global-mode)

(global-set-key (kbd "M-W") 'projectile-kill-buffers)
(global-set-key (kbd "<f5>") 'projectile-regenerate-tags)

;; (setq projectile-completion-system 'grizzl)

;; (add-hook 'grizzl-mode-hook
;;           (lambda ()
;;             (define-key *grizzl-keymap* (kbd "M-n") 'grizzl-set-selection-1)
;;             (define-key *grizzl-keymap* (kbd "M-p") 'grizzl-set-selection+1)
;;             (define-key *grizzl-keymap* (kbd "C-n") 'grizzl-set-selection-1)
;;             (define-key *grizzl-keymap* (kbd "C-p") 'grizzl-set-selection+1)))
