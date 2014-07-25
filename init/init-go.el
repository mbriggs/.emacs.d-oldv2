(provide 'init-go)
(quelpa '(go-mode :fetcher github :repo "dominikh/go-mode.el"))

(add-hook 'before-save-hook 'gofmt-before-save)
