(provide 'init-clojure)

(quelpa 'troncle)
(quelpa 'typed-clojure-mode)
(quelpa 'midje-mode)
(quelpa 'slamhound)
(quelpa 'midje-mode)

(unless (package-installed-p 'cider)
  (package-install 'cider))

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'midje-mode)

(require 'cider)
(add-hook 'clojure-mode-hook 'turn-on-smartparens-strict-mode)
(setq cider-show-error-buffer nil)
(define-key cider-mode-map (kbd "C-e") 'cider-show-error-buffer)
(define-key cider-mode-map (kbd "M-1") 'reset-cider-repl)
(define-key cider-mode-map (kbd "M-2") 'run-cider-tests)
(define-key cider-mode-map (kbd "M-3") 'refresh-cider-repl)
(define-key sp-keymap (kbd "M-k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "M-K") 'sp-backward-kill-sexp)
(evil-define-key 'normal sp-keymap
  (kbd "(") 'wrap-round
  (kbd "\"") 'wrap-quote
  (kbd "[") 'wrap-square
  (kbd ",cs") 'sp-splice-sexp
  (kbd ",cp") 'sp-split-sexp
  (kbd ",cj") 'sp-join-sexp
  (kbd "M-l") 'sp-forward-slurp-sexp
  (kbd "M-h") 'sp-forward-barf-sexp
  (kbd "M-L") 'sp-backward-slurp-sexp
  (kbd "M-H") 'sp-backward-barf-sexp)

(defun wrap-round ()
  (interactive)
  (sp-wrap-with-pair "("))

(defun wrap-quote ()
  (interactive)
  (sp-wrap-with-pair "\""))

(defun wrap-square ()
  (interactive)
  (sp-wrap-with-pair "["))


(defun reset-cider-repl ()
  (interactive)
  (cider-interactive-eval "(user/reset)"))

(defun run-cider-tests ()
  (interactive)
  (cider-interactive-eval "(user/run-tests)"))

(defun refresh-cider-repl ()
  (interactive)

  ;(cider-interactive-eval "(clojure.tools.namespace.repl/refresh)")
  (cider-refresh))
