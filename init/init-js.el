(provide 'init-js)

(quelpa 'js2-mode)
(quelpa 'coffee-mode)
(quelpa 'js2-refactor)
(quelpa '(js2-jshint :fetcher github :repo "michaeljb/js2-jshint"))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json.erb$" . javscript-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.jshintrc$" . javascript-mode))

(autoload 'js2-jshint-setup "js2-jshint")

(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
(add-hook 'js2-init-hook 'js2-jshint-setup)



(setq js-indent-level 2)
(eval-after-load "coffee-mode"
  '(setq coffee-js-mode preferred-javascript-mode
         coffee-tab-width preferred-javascript-indent-level))

(eval-after-load "js2-mode"
  '(progn
     (require 'js2-refactor)
     (evil-define-key 'normal js2-mode-map ",g" 'js2-add-to-globals)
     (define-key js2-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key js2-mode-map (kbd "M-j") nil)

     ;; extract-function: Extracts the marked expressions out into a new named function.
     ;; extract-method: Extracts the marked expressions out into a new named method in an object literal.
     ;; introduce-parameter: Changes the marked expression to a parameter in a local function.
     ;; localize-parameter: Changes a parameter to a local var in a local function.
     ;; expand-object: Converts a one line object literal to multiline.
     ;; contract-object: Converts a multiline object literal to one line.
     ;; wrap-buffer-in-iife: Wraps the entire buffer in an immediately invoked function expression
     ;; inject-global-in-iife: Creates a shortcut for a marked global by injecting it in the wrapping immediately invoked function expression
     ;; add-to-globals-annotation: Creates a /*global */ annotation if it is missing, and adds the var at point to it.
     ;; extract-var: Takes a marked expression and replaces it with a var.
     ;; inline-var: Replaces all instances of a variable with its initial value.
     ;; rename-var: Renames the variable on point and all occurrences in its lexical scope.
     ;; var-to-this: Changes local var a to be this.a instead.
     ;; arguments-to-object: Replaces arguments to a function call with an object literal of named arguments.
     ;; ternary-to-if: Converts ternary operator to if-statement.
     ;; split-var-declaration: Splits a var with multiple vars declared, into several var statements.
     ;; unwrap: Replaces the parent statement with the selected region.
     ;; log-this: Adds a console.log statement for what is at point (or region).
     ;; forward-slurp: Moves the next statement into current function, if-statement, for-loop or while-loop.
     (evil-define-key 'visual js2-mode-map
       (kbd ",rf") 'js2r-extract-function
       (kbd ",rm") 'js2r-extract-method
       (kbd ",rv") 'js2r-extract-var
       (kbd "M-S-J") 'js2r-move-line-down
       (kbd "M-S-K") 'js2r-move-line-up)
     (evil-define-key 'normal js2-mode-map
       (kbd ",re") 'js2r-expand-object
       (kbd ",rc") 'js2r-contract-object
       (kbd ",ri") 'js2r-wrap-buffer-in-iife
       (kbd ",rg") 'js2r-inject-global-in-iife
       (kbd ",rv") 'js2r-extract-var
       (kbd ",rn") 'js2r-inline-var
       (kbd ",rt") 'js2r-var-to-this
       (kbd ",r3") 'js2r-ternary-to-if
       (kbd ",rl") 'js2r-log-this)))

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
