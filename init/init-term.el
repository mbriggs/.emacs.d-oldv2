(provide 'init-term)

(quelpa 'multi-term)

(with-theme-colors
 (defface term-color-black
   `((t (:foreground ,dark1 :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-red
   `((t (:foreground ,red :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-green
   `((t (:foreground ,darkgreen :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-yellow
   `((t (:foreground ,yellow :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-blue
   `((t (:foreground ,blue :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-magenta
   `((t (:foreground ,purple :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-cyan
   `((t (:foreground ,lightgreen :background ,dark3)))
   "Unhelpful docstring.")
 (defface term-color-white
   `((t (:foreground ,light4 :background ,dark3)))
   "Unhelpful docstring."))
'(term-default-fg-color ((t (:inherit term-color-white))))
'(term-default-bg-color ((t (:inherit term-color-black))))

;; ansi-term colors
(setq ansi-term-color-vector
      [term term-color-black term-color-red term-color-green term-color-yellow
            term-color-blue term-color-magenta term-color-cyan term-color-white])



(eval-after-load "term"
  '(progn
     (require 'multi-term)

     (define-key term-raw-map (kbd "M-x") 'smex)
     (define-key term-raw-map (kbd "M-j") 'evil-window-next)
     (define-key term-raw-map (kbd "C-p") 'switch-to-local-project)
     (define-key term-raw-map (kbd "C-S-P") 'prodigy)
     (evil-define-key 'insert term-raw-map (kbd "M-v") 'term-paste)))

(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))

(defun toggle-term-mode ()
  "Toggles term between line mode and char mode"
  (interactive)
  (if (term-in-line-mode)
      (term-char-mode)
    (term-line-mode)))

;; (define-key term-mode-map (kbd "C-c C-j") 'jnm/term-toggle-mode)
;; (define-key term-mode-map (kbd "C-c C-k") 'jnm/term-toggle-mode)

;; (define-key term-raw-map (kbd "C-c C-j") 'jnm/term-toggle-mode)
;; (define-key term-raw-map (kbd "C-c C-k") 'jnm/term-toggle-mode)
