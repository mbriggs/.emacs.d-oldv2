(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-enforce-face ((t (:underline "#3a4055"))))
 '(company-preview ((t (:foreground "#d4cfc9"))))
 '(company-preview-common ((t (:foreground "controlShadowColor"))))
 '(company-preview-search ((t (:inherit company-preview))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip :background "#3a4055"))))
 '(company-scrollbar-fg ((t (:background "#2b2b2b"))))
 '(company-tooltip ((t (:background "#5a647e" :foreground "#f4f1ed"))))
 '(company-tooltip-common ((t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :foreground "#f9f7f3"))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "#6d9cbe"))))
 '(compilation-info ((t (:foreground "#ffc66d"))))
 '(magit-section-title ((t (:background "#5a647e" :foreground "#f9f7f3" :weight normal))))
 '(show-paren-match ((t (:background "#5a647e" :foreground "#d4cfc9"))))
 '(sp-show-pair-enclosing ((t (:background "#5a647e" :foreground "#d4cfc9"))))
 '(sp-show-pair-match-face ((t (:background "#5a647e" :foreground "#d4cfc9"))))
 '(trailing-whitespace ((t (:background "#3a4055")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-clang company-xcode company-ropemacs company-cmake company-capf
                  (company-dabbrev-code company-keywords)
                  company-oddmuse company-files company-dabbrev)))
 '(enh-ruby-bounce-deep-indent t)
 '(enh-ruby-use-ruby-mode-show-parens-config t)
 '(js2-auto-indent-p t)
 '(js2-basic-offset 2)
 '(js2-boring-indentation nil)
 '(js2-consistent-level-indent-inner-bracket t)
 '(js2-mode-show-parse-errors t)
 '(js2-mode-show-strict-warnings t)
 '(ruby-refactor-add-parens t)
 '(ruby-refactor-let-position (quote closest))
 '(scss-compile-at-save nil))
