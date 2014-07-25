(provide 'init-git)

(quelpa 'magit)
(quelpa 'yagist)
(quelpa 'diff-hl)
(quelpa 'gh)
(quelpa 'helm)
(quelpa 'git-timemachine)
(quelpa '(open-github-from-here :fetcher github :repo "mbriggs/emacs-open-github-from-here"))
(quelpa '(hub :fetcher url :url "https://gist.githubusercontent.com/travisjeffery/632bf58f06c9a882733e/raw/f3a273477031b43585ef244d2021c49cfd887a65/hub.el"))

(autoload 'hub-list-pull-requests "hub" nil t)
(autoload 'hub-open-pull-request "hub" nil t)
(autoload 'hub-fork "hub" nil t)
(autoload 'hub-create "hub" nil t)
(autoload 'hub-browse "hub" nil t)
(autoload 'hub-compare "hub" nil t)
(autoload 'hub-checkout "hub" nil t)

(setq magit-emacsclient-executable "/usr/local/bin/emacsclient")

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
