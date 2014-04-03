(provide 'init-js)

(quelpa 'js3-mode)
(quelpa 'coffee-mode)
(autoload 'js3-mode "js3" nil t)

(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.json.erb$" . javscript-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))


(setq js-indent-level 2)
(eval-after-load "coffee-mode"
  `(setq coffee-js-mode preferred-javascript-mode
         coffee-tab-width preferred-javascript-indent-level))

(eval-after-load 'js3-mode
  '(font-lock-add-keywords
    'js3-mode `(("\\(function\\)("
                 (0 (progn (compose-region (match-beginning 1)
                                           (match-end 1) "λ")
                           nil))))))
