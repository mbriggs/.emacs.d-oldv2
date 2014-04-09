(provide 'init-keymaps)
(quelpa '(etags-select :fetcher wiki))

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
(global-set-key (kbd "M-W") 'only-current-buffer)
(global-set-key (kbd "M-q") 'save-buffers-kill-emacs)
(global-set-key (kbd "M-.") 'etags-select-find-tag)
(global-set-key (kbd "M-o") 'occur)
(global-set-key (kbd "M-S-o") 'multi-occur)

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
(define-key evil-normal-state-map (kbd "M-n") 'next-error)
(define-key evil-normal-state-map (kbd "M-P") 'session-jump-to-last-change)
(define-key evil-normal-state-map (kbd "M-p") 'previous-error)
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


(global-set-key (kbd "M-q") 'evil-quit-all)
(evil-define-key 'visual global-map
  (kbd "M-d") 'duplicate-region)

(evil-define-key 'normal global-map
  (kbd "M-<backspace>") 'kill-whole-line
  (kbd "M-d") 'duplicate-line)

(evil-define-key 'insert global-map
  (kbd "M-d") 'duplicate-line
  (kbd "M-<backspace>") 'kill-whole-line
  (kbd "A-<backspace>") 'backward-kill-word
  (kbd "M-J") 'evil-join
  (kbd "M-S-<return>") 'evil-open-above
  (kbd "M-<return>") 'evil-open-below
  (kbd "M-<left>") 'evil-first-non-blank
  (kbd "M-<right>") 'move-end-of-line)


(global-set-key (kbd "M-f") 'isearch-forward)
(global-set-key (kbd "M-r") 'isearch-backward)
(define-key isearch-mode-map [escape] 'isearch-cancel)
(define-key isearch-mode-map (kbd "M-f") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-r") 'isearch-repeat-backward)

;;; ex-mode

(defun ex-mode-mapping (cmd)
  (let ((binding (car cmd))
        (fn (cdr cmd)))
    (evil-ex-define-cmd binding fn)))

(mapc 'ex-mode-mapping
      '(("!"                        . shell-command)
        ("log"                      . magit-log)
        ("[buff]ers"                . ibuffer)
        ("[br]branch"               . magit-branch-manager)
        ("deft"                     . deft)
        ("reset-directory"          . reset-current-dir)
        ("history"                  . magit-file-log)
        ("bundle"                   . bundle-install)
        ("[chan]nel"                . ido-erc-buffer)
        ("clean"                    . clean-up-buffer-or-region)
        ("align"                    . align-regexp)
        ("[er]eval-region"          . eval-region)
        ("[eb]eval-buffer"          . eval-buffer)
        ("ack"                      . ack)
        ("[al]ack-location"         . ack-location)
        ("[gl]gist-list"            . yagist-list)
        ("[gr]gist-region"          . yagist-region)
        ("[grp]gist-region-private" . yagist-region-private)
        ("erc"                      . start-erc)
        ("[sh]shell"                . shell)
        ("[de]debug-elisp"          . edebug-defun)
        ("[proj]ect"                . switch-to-local-project)
        ("occur"                    . projectile-multi-occur)
        ("dired"                    . dired)))
