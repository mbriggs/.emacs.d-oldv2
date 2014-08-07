(provide 'init-git)

(quelpa 'magit)
(quelpa 'yagist)
(quelpa 'diff-hl)
(quelpa 'gh)
(quelpa 'helm)
(quelpa 'git-timemachine)
(quelpa '(open-github-from-here :fetcher github :repo "mbriggs/emacs-open-github-from-here"))
(quelpa 'magit-gh-pulls)

(setq magit-emacsclient-executable "/usr/local/bin/emacsclient")

(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(defun magit-gh-pulls-setup (repoid)
  (interactive "suser/repo: ")
  (shell-command "git config --add magit.extension gh-pulls")
  (shell-command (concat "git config magit.gh-pulls-repo " repoid)))

(add-hook 'git-commit-mode-hook 'insert-ticket-number-from-branch-name)

(defun insert-ticket-number-from-branch-name ()
  (let* ((current-branch (car (vc-git-branches)))
         (ticket-number (replace-regexp-in-string ".+\\(/.*\\)$" ""
                                                  current-branch nil nil 1)))
    (when (string-match "^.+/" current-branch)
      (newline)
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
