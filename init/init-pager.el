(provide 'init-pager)

(quelpa '(emacs-pager :repo "mbriggs/emacs-pager" :fetcher github))

(add-to-list 'auto-mode-alist '("\\.emacs-pager$" . emacs-pager-mode))

(eval-after-load "emacs-pager"
  '(progn
     (push 'emacs-pager-mode evil-insert-state-modes)
     (evil-define-key 'normal emacs-pager-mode-map (kbd "q") 'emacs-pager-kill-pager)))
