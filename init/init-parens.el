(provide 'init-parens)

(quelpa '(smartparens :fetcher github :repo "Fuco1/smartparens"))
(require 'smartparens-config)
(smartparens-global-mode t)

(with-theme-colors
 (set-face-attribute 'sp-show-pair-match-face nil
                     :foreground light4
                     :background dark4)
 (set-face-attribute 'sp-show-pair-mismatch-face nil
                     :foreground light3
                     :background red)
 (set-face-attribute 'sp-pair-overlay-face nil
                     :background dark3)
 (set-face-attribute 'sp-wrap-overlay-face nil
                     :inherit 'sp-pair-overlay-face)
 (set-face-attribute 'sp-wrap-tag-overlay-face nil
                     :inherit 'sp-pair-overlay-face))
