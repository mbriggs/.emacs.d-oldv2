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
                 init-clojure
                 init-crontab
                 init-deft
                 init-dired
                 init-session

                 init-keymaps
                 init-settings))


(require 'server)
(unless (server-running-p)
  (server-start))
(setq custom-file "~/.emacs.d/init/init-custom.el")
(load custom-file)
