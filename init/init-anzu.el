(provide 'init-anzu)

(global-anzu-mode +1)

(with-theme-colors
 (set-face-attribute 'anzu-mode-line nil
                     :foreground orange
                     :weight 'normal))
