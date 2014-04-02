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
