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
(require 'clojure-mode)
;; (add-hook 'clojure-mode-hook 'turn-on-smartparens-strict-mode)
(setq cider-show-error-buffer nil)
(define-key cider-mode-map (kbd "M-e") 'cider-visit-error-buffer)
(define-key cider-mode-map (kbd "M-1") 'reset-cider-repl)
(define-key cider-mode-map (kbd "M-2") 'run-cider-tests)
(define-key cider-mode-map (kbd "M-3") 'refresh-cider-repl)
(define-key cider-mode-map (kbd "M-?") 'cider-doc)

(eval-after-load "clojure-mode"
  (lambda ()
    (define-clojure-indent
      (while-let 2)
      (defroutes 'defun)
      (GET 2)
      (POST 2)
      (PUT 2)
      (DELETE 2)
      (HEAD 2)
      (ANY 2)
      (context 2))))


(defun reset-cider-repl ()
  (interactive)
  (cider-interactive-eval "(user/reset)"))

(defun my-cider-refresh ()
  "Refresh loaded code."
  (interactive)
  (cider-tooling-eval
   "(clojure.core/require 'clojure.tools.namespace.repl) (clojure.tools.namespace.repl/refresh)"
   (cider-interactive-eval-handler (current-buffer))))
