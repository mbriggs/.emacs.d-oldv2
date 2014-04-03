;;; init

(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))


(mapc 'require '(init-bootstrap
                 init-defuns
                 init-appearance

                 init-ido
                 init-evil
                 init-completion
                 init-projectile
                 init-magit
                 init-expand-region
                 init-web
                 init-parens
                 init-modeline
                 init-markdown
                 init-js
                 init-flycheck
                 init-help
                 init-yaml
                 init-ruby
                 init-multiple-cursors
                 init-project-explorer
                 init-games
                 init-volatile-highlights
                 init-erc
                 init-snippets
                 init-ack
                 init-sass
                 init-anzu
                 init-crontab
                 init-deft

                 init-keymaps
                 init-settings))


(require 'server)
(unless (server-running-p)
  (server-start))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "#d4cfc9"))))
 '(company-preview-common ((t (:foreground "controlShadowColor"))))
 '(company-preview-search ((t (:inherit company-preview))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip :background "#3a4055"))))
 '(company-scrollbar-fg ((t (:background "#2b2b2b"))))
 '(company-tooltip ((t (:background "#5a647e" :foreground "#f4f1ed"))))
 '(company-tooltip-common ((t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :foreground "#f9f7f3"))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "#6d9cbe"))))
 '(sp-show-pair-enclosing ((t (:background "#6d9cbe"))))
 '(sp-show-pair-match-face ((t (:background "#6d9cbe"))))
 '(trailing-whitespace ((t (:background "#3a4055")))))
