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

                   init-keymaps
                   init-settings))

(unless (server-running-p)
  (server-start))
