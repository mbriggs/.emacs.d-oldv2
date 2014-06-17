(provide 'init-git)

(quelpa 'magit)
(quelpa 'yagist)
(quelpa 'diff-hl)
(quelpa '(open-github-from-here :fetcher github :repo "mbriggs/emacs-open-github-from-here"))
(setq magit-emacsclient-executable "/usr/local/bin/emacsclient")

(add-hook 'git-commit-mode-hook 'insert-ticket-number-from-branch-name)

(defun insert-ticket-number-from-branch-name ()
  (let* ((current-branch (car (vc-git-branches)))
         (ticket-number (replace-regexp-in-string ".+\\(/.*\\)$" ""
                                                  current-branch nil nil 1)))
    (when (string-match "^.+/" current-branch)
      (newline)
      (insert (concat "Ticket: " ticket-number))
      (goto-char (point-min)))))

(global-set-key (kbd "<f1>") 'magit-status)
(define-key evil-normal-state-map (kbd "<f4>") 'magit-checkout)
(global-diff-hl-mode +1)

(require 'open-github-from-here)
(setq open-github-from-here:command (expand-file-name "~/.emacs.d/make-github-url-from-file"))
(require 'evil)
(push 'git-commit-mode evil-emacs-state-modes)

;; (add-hook 'git-commit-mode-hook
;;           '(lambda ()
;;              (goto-char (point-min))))
