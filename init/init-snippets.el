(provide 'init-snippets)

(quelpa 'yasnippet)
(quelpa 'auto-yasnippet)

(add-hook 'after-init-hook 'yas-global-mode)

(eval-after-load "yasnippet"
  '(progn
     (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
     (yas-reload-all))) 

(autoload 'aya-create "auto-yasnippet")
(autoload 'aya-expand "auto-yasnippet")


(define-key evil-insert-state-map (kbd "M-y") 'aya-expand)
(define-key evil-insert-state-map (kbd "M-Y") 'aya-create)
