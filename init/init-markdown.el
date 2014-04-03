(provide 'init-markdown)

(quelpa '(markdown-mode :url "git://jblevins.org/git/markdown-mode.git" :fetcher git))
(autoload 'markdown-mode "markdown-mode" nil t)
(autoload 'gfm-mode "markdown-mode" nil t)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.text$" . gfm-mode))
