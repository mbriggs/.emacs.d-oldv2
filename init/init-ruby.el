(provide 'init-ruby)

(quelpa 'rbenv)
(require 'rbenv)
(global-rbenv-mode +1)
(rbenv-use-global)

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(quelpa 'bundler)
(quelpa 'rspec-mode)
(quelpa 'ruby-refactor)
(quelpa 'enh-ruby-mode)
(quelpa 'rails-log-mode)
(quelpa 'rubocop)
(quelpa 'rbenv)
(quelpa 'inf-ruby)

(eval-after-load "rspec-mode"
  '(progn
     (setq rspec-use-rake-flag nil)
     (setq rspec-spec-command "rspec")
     (setq rspec-use-spring-when-possible t)

     (define-key enh-ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)

     (evil-define-key 'visual enh-ruby-mode-map
       ",rm" 'ruby-refactor-extract-to-method
       ",rv" 'ruby-refactor-extract-local-variable
       ",rl" 'ruby-refactor-extract-to-let)

     (evil-define-key 'normal enh-ruby-mode-map
       ",t," 'projectile-toggle-between-implementation-and-test
       ",tf" 'rspec-verify
       ",tt" 'rspec-verify-single
       ",ta" 'rspec-verify-all
       ",tl" 'rspec-rerun
       ",rv" 'ruby-refactor-extract-local-variable
       ",ra" 'ruby-refactor-add-parameter
       ",rl" 'ruby-refactor-extract-to-let)))
