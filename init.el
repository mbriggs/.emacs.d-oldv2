;;; init

(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))


(mapcar 'require '(init-bootstrap
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

                   init-keymaps
                   init-settings))

(require 'server)
(unless (server-running-p)
  (server-start))
