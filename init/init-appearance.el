(provide 'init-appearance)
(require 'dash)
(require 'base16-railscasts-theme)

;; only turn off menus if not osx
(if (not (eq system-type 'darwin))
    (menu-bar-mode -1))


(let ((font (if (featurep 'ns) "Menlo-15" "Menlo-11")))
  (set-frame-font font)
  (add-to-list 'default-frame-alist
               `(font . ,font)))


(line-number-at-pos)

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (when (and
                   (not (eq major-mode 'Custom-mode))
                   (not (eq major-mode 'shell-mode))
                   (not (eq major-mode 'emacs-pager-mode))
                   (not (eq major-mode 'term-mode))
                   (not (eq major-mode 'eshell-mode))
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


(with-theme-colors
 (set-face-attribute 'fringe nil
                     :background dark3
                     :foreground blue)
 (set-face-attribute 'region nil
                     :background dark4
                     :foreground light3))

(setq linum-format (lambda (line)
                     (propertize
                      (format (concat " %"
                                      (number-to-string
                                       (length (number-to-string
                                                (line-number-at-pos (point-max)))))
                                      "d ")
                              line)
                      'face 'linum)))

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
                                 prodigy-mode
                                 prodigy-view-mode
                                 term-mode
                                 eshell-mode
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



(require 'highlight-cl)
(add-hook 'emacs-lisp-mode-hook 'highlight-cl-add-font-lock-keywords)

(require 'column-enforce-mode)
(defvar *dont-column-enforce* '(shell-mode prodigy-mode term-mode eshell-mode emacs-pager-mode))

(add-hook 'after-change-major-mode-hook
          '(lambda ()
             (unless (-contains? *dont-column-enforce* major-mode) (100-column-rule))))
