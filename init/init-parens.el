(provide 'init-parens)

(quelpa '(smartparens :fetcher github :repo "Fuco1/smartparens"))
(require 'smartparens-config)
(show-smartparens-global-mode +1)
(smartparens-global-mode +1)

(with-theme-colors
 (set-face-attribute 'sp-show-pair-mismatch-face nil
                     :foreground light3
                     :background red)
 (set-face-attribute 'sp-pair-overlay-face nil
                     :background dark3)
 (set-face-attribute 'sp-wrap-overlay-face nil
                     :inherit 'sp-pair-overlay-face)
 (set-face-attribute 'sp-wrap-tag-overlay-face nil
                     :inherit 'sp-pair-overlay-face))

(define-key sp-keymap (kbd "M-k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "M-K") 'sp-backward-kill-sexp)
(define-key (kbd "M-H") 'sp-backward-barf-sexp)
(define-key (kbd "M-h") 'sp-backward-slurp-sexp)
(define-key (kbd "M-L") 'sp-forward-barf-sexp)
(define-key (kbd "M-l") 'sp-forward-slurp-sexp)
(evil-define-key 'normal sp-keymap
  (kbd "(") 'wrap-round
  (kbd "\"") 'wrap-quote
  (kbd "[") 'wrap-square
  (kbd "P") 'sp-splice-sexp
  (kbd ",cp") 'sp-split-sexp
  (kbd ",cj") 'sp-join-sexp)

(defun wrap-round ()
  (interactive)
  (sp-wrap-with-pair "("))

(defun wrap-quote ()
  (interactive)
  (sp-wrap-with-pair "\""))

(defun wrap-square ()
  (interactive)
  (sp-wrap-with-pair "["))
