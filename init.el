;;; init

(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))


(mapc 'require '(init-bootstrap
                 init-evil
                 init-defuns
                 init-appearance

                 init-ido
                 init-completion
                 init-projectile
                 init-git
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
                 init-games
                 init-volatile-highlights
                 init-erc
                 init-snippets
                 init-ack
                 init-sass
                 init-misc
                 init-anzu
                 init-clojure
                 init-crontab
                 init-deft
                 init-dired
                 init-term
                 init-pager
                 init-prodigy
                 init-peepopen
                 init-java
                 init-mongo
                 init-shell
                 init-ag

                 init-keymaps
                 init-settings))

(let ((secret-path (expand-file-name "~/Dropbox/secrets.el")))
  (when (file-exists-p secret-path)
    (load-file secret-path)))

(require 'server)
(unless (server-running-p)
  (server-start))
(setq custom-file "~/.emacs.d/init/init-custom.el")
(load custom-file)
