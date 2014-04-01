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
            (when (not (eq major-mode 'shell-mode))
              (setq show-trailing-whitespace t))))
