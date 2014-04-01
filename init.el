;;; init

(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))


(mapcar 'require '(init-bootstrap
                   init-appearance

                   init-ido
                   init-evil
                   init-completion

                   init-keymaps
                   init-settings))
