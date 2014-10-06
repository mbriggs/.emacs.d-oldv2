(provide 'init-js)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json.erb$" . javscript-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.jshintrc$" . javascript-mode))

(autoload 'js2-jshint-setup "js2-jshint")
(autoload 'gulpjs-start-task "gulpjs" "Start a gulp task." t)

(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
(add-hook 'js2-init-hook 'js2-jshint-setup)


(setq js-indent-level 2)
(eval-after-load "coffee-mode"
  '(setq coffee-js-mode preferred-javascript-mode
         coffee-tab-width preferred-javascript-indent-level))

(eval-after-load "js2-mode"
  '(progn
     (evil-define-key 'normal js2-mode-map ",g" 'js2-add-to-globals)
     (define-key js2-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key js2-mode-map (kbd "M-j") nil)))

;; (font-lock-add-keywords
;;  'js2-mode `(("function *([^)]*) *{ *\\(return\\) "
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "\u2190")
;;                         nil)))))

;; (font-lock-add-keywords
;;  'js2-mode `(("\\(function\\)("
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "λ")
;;                         nil)))))
