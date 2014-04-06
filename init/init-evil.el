(provide 'init-evil)

(quelpa 'evil)
(quelpa 'surround)
(quelpa 'ace-jump-mode)
(quelpa 'evil-indent-textobject)
(global-surround-mode 1)
(evil-mode 1)


(global-set-key (kbd "M-;") 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
(define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
