(provide 'init-dired)

(require 'dired+)

(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "gls")
(setq wdired-allow-to-change-permissions t)
(setq dired-listing-switches "-alh")
(define-key dired-mode-map (kbd "M-e") 'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "TAB") 'dired-hide-details-mode)

(define-key dired-mode-map (kbd "b") nil)
(define-key dired-mode-map (kbd "e") nil)
(define-key dired-mode-map (kbd "-") nil)
(define-key dired-mode-map (kbd "E") nil)

(with-theme-colors
 (set-face-attribute 'diredp-dir-priv nil
                     :background dark2
                     :foreground darkgreen)
 (set-face-attribute 'diredp-write-priv nil
                     :background dark4)
 (set-face-attribute 'diredp-read-priv nil
                     :background dark3)
 (set-face-attribute 'diredp-exec-priv nil
                     :background dark2)
 (set-face-attribute 'diredp-number nil
                     :foreground dark4)
 (set-face-attribute 'diredp-date-time nil
                     :foreground light1)
 (set-face-attribute 'diredp-file-suffix nil
                     :foreground blue)
 (set-face-attribute 'diredp-file-name nil
                     :foreground light4)
 (set-face-attribute 'diredp-dir-heading nil
                     :foreground darkgreen
                     :background dark1)
 (set-face-attribute 'dired-directory nil
                     :foreground darkgreen)
 (set-face-attribute 'diredp-flag-mark nil
                     :foreground orange
                     :background dark3)
 (set-face-attribute 'diredp-flag-mark-line nil
                     :background dark4))
