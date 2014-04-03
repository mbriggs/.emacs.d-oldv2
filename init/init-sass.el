(provide 'init-sass)

(quelpa 'sass-mode)

(add-to-list 'auto-mode-alist '("\\.sass.erb$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss.erb$" . scss-mode))
