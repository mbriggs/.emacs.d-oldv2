(provide 'init-modeline)

(quelpa '(smart-mode-line :repo "Bruce-Connor/smart-mode-line" :fetcher github))
(setq sml/vc-mode-show-backend t)
(sml/setup)
(sml/apply-theme 'respectful)
