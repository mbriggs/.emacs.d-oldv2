(provide 'init-js)

(quelpa 'js3-mode)
(quelpa 'coffee-mode)
(quelpa '(js3-refactor :fetcher github :repo "katyo/js3-refactor"))

(autoload 'js3-mode "js3" nil t)

(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.json.erb$" . javscript-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))


(setq js-indent-level 2)
(eval-after-load "coffee-mode"
  '(setq coffee-js-mode preferred-javascript-mode
         coffee-tab-width preferred-javascript-indent-level))

(eval-after-load "js3"
  '(progn
     (require 'js3-refactor)
     (evil-define-key 'normal js3-mode-map ",g" 'js3-add-to-globals)
     (define-key js3-mode-map (kbd "RET") 'reindent-then-newline-and-indent)

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
     (evil-define-key 'visual js3-mode-map
       (kbd ",rf") 'js3r-extract-function
       (kbd ",rm") 'js3r-extract-method
       (kbd ",rv") 'js3r-extract-var
       (kbd "M-S-J") 'js3r-move-line-down
       (kbd "M-S-K") 'js3r-move-line-up)
     (evil-define-key 'normal js3-mode-map
       (kbd ",re") 'js3r-expand-object
       (kbd ",rc") 'js3r-contract-object
       (kbd ",ri") 'js3r-wrap-buffer-in-iife
       (kbd ",rg") 'js3r-inject-global-in-iife
       (kbd ",rv") 'js3r-extract-var
       (kbd ",rt") 'js3r-var-to-this
       (kbd ",r3") 'js3r-ternary-to-if
       (kbd ",rl") 'js3r-log-this)))

;; (font-lock-add-keywords
;;  'js3-mode `(("function *([^)]*) *{ *\\(return\\) "
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "\u2190")
;;                         nil)))))

;; (font-lock-add-keywords
;;  'js3-mode `(("\\(function\\)("
;;               (0 (progn (compose-region (match-beginning 1)
;;                                         (match-end 1) "λ")
;;                         nil)))))
