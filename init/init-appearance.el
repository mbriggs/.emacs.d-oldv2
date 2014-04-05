(provide 'init-appearance)



(quelpa '(base16-emacs
	  :repo "neil477/base16-emacs"
	  :fetcher github))

(require 'base16-railscasts-theme)

;; only turn off menus if not osx
(if (not (eq system-type 'darwin))
    (menu-bar-mode -1))

(if (featurep 'ns)
    (set-frame-font "Menlo-15" t)
  (set-frame-font "Menlo-11" t))

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (and
                   (not (eq major-mode 'Custom-mode))
                   (not (eq major-mode 'shell-mode)))
              (setq show-trailing-whitespace t))))

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))


(unless (require 'rainbow-mode nil t)
  (with-temp-buffer
    (url-insert-file-contents
     "http://git.savannah.gnu.org/cgit/emacs/elpa.git/plain/packages/rainbow-mode/rainbow-mode.el")
    (package-install-from-buffer)))

(dolist (hook '(css-mode-hook
                html-mode-hook
                js-mode-hook
                emacs-lisp-mode-hook
                org-mode-hook
                text-mode-hook))
  (add-hook hook 'rainbow-mode))

;; (defface  my-parens       `((((class color)) (:foreground "#BEA75D"))) "custom parens"  :group 'faces)
;; (defface  my-braces       `((((class color)) (:foreground ,sol-blue  ))) "custom braces"  :group 'faces)
;; (defface  my-brackets     `((((class color)) (:foreground ,sol-violet))) "custom brackets" :group 'faces)
;; (defface  my-dot          `((((class color)) (:foreground "#BEA75D"))) "custom brackets" :group 'faces)
;; (defface  my-semis        `((((class color)) (:foreground "#BEA75D"))) "custom semicolons" :group 'faces)
;; (defface  my-double-quote `((((class color)) (:foreground ,sol-red))) "custom special" :group 'faces)

;; (defvar tweak-syntax-blacklist '(magit-status-mode
;;                                  magit-log-mode
;;                                  magit-commit-mode
;;                                  magit-branch-manager-mode
;;                                  deft-mode
;;                                  ruby-mode
;;                                  haml-mode
;;                                  web-mode
;;                                  gfm-mode
;;                                  org-mode
;;                                  erc-mode))

;; (defun tweak-syntax ()
;;   (if (not (member major-mode tweak-syntax-blacklist))
;;       (mapcar (lambda (x) (font-lock-add-keywords nil x))
;;               '((("#?['`]*(\\|)" . 'my-parens))
;;                 (("#?\\^?{\\|}" . 'my-braces))
;;                 (("\\[\\|\\]" . 'my-brackets))
;;                 (("\\." . 'my-dot))
;;                 (("; *$" . 'my-semis))
;;                 (("#?\"" 0 'my-double-quote prepend))
;;                 (("#?\'" 0 'my-double-quote prepend))
;;                 (("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 'font-lock-warning-face t))))))



;; (add-hook 'after-change-major-mode-hook 'tweak-syntax)

;; (provide 'my-defuns)


(defmacro with-theme-colors (&rest body)
  `(let ((dark1 "#2b2b2b")
         (dark2 "#272935")
         (dark3 "#3a4055")
         (dark4 "#5a647e")
         (light1 "#d4cfc9")
         (light2 "#e6e1dc")
         (light3 "#f4f1ed")
         (light4 "#f9f7f3")
         (red "#da4939")
         (orange "#cc7833")
         (yellow "#ffc66d")
         (lightgreen "#a5c261")
         (darkgreen "#519f50")
         (blue "#6d9cbe")
         (purple "#b6b3eb")
         (brown "#bc9458"))
     ,@body))





;; (quelpa 'fill-column-indicator)
;; (add-hook 'after-init-hook
;;           (lambda ()
;;             (setq fci-rule-column 90)
;;             (with-theme-colors
;;              (setq fci-rule-color dark3))

;;             (define-globalized-minor-mode global-fci-mode fci-mode
;;               (lambda () (fci-mode 1)))
;;             (global-fci-mode 1)))
