(provide 'init-ruby)

(quelpa 'rvm)
(rvm-use-default)

(quelpa 'bundler)
(quelpa 'rspec-mode)
(quelpa 'ruby-refactor)
(quelpa 'enh-ruby-mode)
(quelpa 'rails-log-mode)

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
