(provide 'init-appearance)


(quelpa '(base16-emacs
          :repo "neil477/base16-emacs"
          :fetcher github))
(quelpa 'dash)
(require 'dash)

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
                   (not (eq major-mode 'shell-mode))
                   (not (eq major-mode 'emacs-pager-mode))
                   (not (eq major-mode 'term-mode))
                   (not (eq major-mode 'ibuffer-mode))
                   (not (eq major-mode 'rspec-compilation-mode))
                   (not (eq major-mode 'prodigy-mode)))
              (setq show-trailing-whitespace t))))

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

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

(with-theme-colors
 (defface  my-parens       `((((class color)) (:foreground ,dark4))) "custom parens"  :group 'faces)
 (defface  my-braces       `((((class color)) (:foreground ,blue  ))) "custom braces"  :group 'faces)
 (defface  my-brackets     `((((class color)) (:foreground ,purple))) "custom brackets" :group 'faces)
 (defface  my-dot          `((((class color)) (:foreground ,dark4))) "custom brackets" :group 'faces)
 (defface  my-semis        `((((class color)) (:foreground ,dark4))) "custom semicolons" :group 'faces)
 (defface  my-double-quote `((((class color)) (:foreground ,darkgreen))) "custom special" :group 'faces))

(defvar tweak-syntax-blacklist '(magit-status-mode
                                 magit-log-mode
                                 magit-commit-mode
                                 magit-branch-manager-mode
                                 term-mode
                                 deft-mode
                                 ruby-mode
                                 haml-mode
                                 web-mode
                                 gfm-mode
                                 org-mode
                                 erc-mode))

(defun tweak-syntax ()
  (if (not (member major-mode tweak-syntax-blacklist))
      (mapcar (lambda (x) (font-lock-add-keywords nil x))
              '((("#?['`]*(\\|)" . 'my-parens))
                (("#?\\^?{\\|}" . 'my-braces))
                (("\\[\\|\\]" . 'my-brackets))
                (("\\." . 'my-dot))
                (("; *$" . 'my-semis))
                (("#?\"" 0 'my-double-quote prepend))
                (("#?\'" 0 'my-double-quote prepend))
                (("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 'font-lock-warning-face t))))))



(add-hook 'after-change-major-mode-hook 'tweak-syntax)



(quelpa 'highlight-cl)
(require 'highlight-cl)
(add-hook 'emacs-lisp-mode-hook 'highlight-cl-add-font-lock-keywords)

(quelpa 'column-enforce-mode)
(require 'column-enforce-mode)
(defvar *dont-column-enforce* '(shell-mode prodigy-mode term-mode emacs-pager-mode))

(add-hook 'after-change-major-mode-hook
          '(lambda ()
             (unless (-contains? *dont-column-enforce* major-mode) (100-column-rule))))
