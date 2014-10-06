(provide 'init-ruby)

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(defun ruby-method-space-replace ()
  "When pressing space while naming a defined method, insert an underscore"
  (interactive)
  (if (and (looking-back "def .+")
           (not (and
                 (looking-at ".*)$")
                 (looking-back "(.*"))))
      (insert "_")
    (insert " ")))

(eval-after-load "rspec-mode"
  '(progn
     (setq rspec-use-rake-flag nil)
     (setq rspec-spec-command "rspec")
     (setq rspec-use-spring-when-possible t)

     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key ruby-mode-map (kbd "SPC") 'ruby-method-space-replace)

     (evil-define-key 'visual ruby-mode-map
       ",rm" 'ruby-refactor-extract-to-method
       ",rv" 'ruby-refactor-extract-local-variable
       ",rl" 'ruby-refactor-extract-to-let)

     (evil-define-key 'normal ruby-mode-map
       ",t," 'projectile-toggle-between-implementation-and-test
       ",tf" 'rspec-verify
       ",tt" 'rspec-verify-single
       ",ta" 'rspec-verify-all
       ",tl" 'rspec-rerun
       ",rv" 'ruby-refactor-extract-local-variable
       ",ra" 'ruby-refactor-add-parameter
       ",rl" 'ruby-refactor-extract-to-let)))
