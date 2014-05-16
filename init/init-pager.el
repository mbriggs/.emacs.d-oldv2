(provide 'init-pager)

(quelpa '(emacs-pager :repo "mbriggs/emacs-pager" :fetcher github))
(quelpa '(vlfi :repo "m00natic/vlfi" :fetcher github))
(require 'vlf-integrate)

(add-to-list 'auto-mode-alist '("\\.emacs-pager$" . emacs-pager-mode))

(eval-after-load "emacs-pager"
  '(progn
     (push 'emacs-pager-mode evil-insert-state-modes)
     (evil-define-key 'normal emacs-pager-mode-map (kbd "q") 'emacs-pager-kill-pager)))
