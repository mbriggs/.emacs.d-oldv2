(provide 'init-ruby)

(quelpa 'rvm)
(rvm-use-default)

(quelpa 'bundler)
(quelpa 'rspec-mode)
(quelpa 'ruby-refactor)
(quelpa 'ruby-end)

(add-hook 'ruby-mode-hook 'ruby-end-mode)
(eval-after-load "ruby-end"
  '(progn
     (setq ruby-end-insert-newline nil)

     (define-key ruby-end-mode-map (kbd "RET")
       (lambda ()
         (interactive)
         (if (ruby-end-expand-p)
             (ruby-end-insert-end))
         (let ((ruby-end-mode nil))
           (call-interactively
            (key-binding
             (read-kbd-macro "RET"))))))))
