(provide 'init-js)

(quelpa '(js2-mode :repo "mooz/js2-mode" :fetcher github))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
