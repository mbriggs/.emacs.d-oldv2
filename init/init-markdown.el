(provide 'init-markdown)

(quelpa '(markdown-mode :url "git://jblevins.org/git/markdown-mode.git" :fetcher git))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
