(provide 'init-keymaps)

;;; global

(global-set-key (kbd "M-a") 'mark-whole-buffer)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-\\") 'highlight-symbol-at-point)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-j") 'other-window)
(global-set-key (kbd "M-b") 'ibuffer)
(global-set-key (kbd "M-v") 'evil-paste-after)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-w") 'quit-window)
(global-set-key (kbd "M-q") 'save-buffers-kill-emacs)

;;; normal

(define-key evil-normal-state-map " m" 'evil-jump-item)
(define-key evil-normal-state-map ",," 'evil-buffer)
(define-key evil-normal-state-map "-" 'delete-other-windows)
(define-key evil-normal-state-map "b" 'ido-switch-buffer)
(define-key evil-normal-state-map "E" 'ido-find-file)
(define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
(define-key evil-normal-state-map "H" 'evil-first-non-blank)
(define-key evil-normal-state-map "Y" 'copy-to-end-of-line)
(define-key evil-normal-state-map "L" 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "<tab>") 'indent-for-tab-command)
(define-key evil-normal-state-map (kbd "<C-return>") 'new-line-in-normal-mode)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map (kbd "M-j") 'evil-window-next)
(define-key evil-normal-state-map (kbd "C-SPC") 'comment-or-uncomment-region-or-line)


;;; esc ALWAYS quits

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'keyboard-quit)

;;; editing
