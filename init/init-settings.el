(provide 'init-settings)

(setq ns-use-srgb-colorspace t)
(setq create-lockfiles nil)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(setq fill-column 85)
(setq initial-major-mode 'emacs-lisp-mode)
(setq browse-url-generic-program "google-chrome")
(setq initial-scratch-message nil)

(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

(global-auto-revert-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)
(delete-selection-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode t)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style '(8 . 0))
(tooltip-mode -1)
(setq-default indicate-buffer-boundaries nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq indicate-empty-lines nil)
(recentf-mode 1)
(setq recentf-max-saved-items 80
      recentf-exclude '("/tmp/" "/ssh:"))



(defun save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'save-all)
