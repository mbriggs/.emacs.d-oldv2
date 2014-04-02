(provide 'init-ido)

(quelpa 'ido-vertical-mode)
(quelpa 'flx-ido)
(quelpa 'ido-ubiquitous)
(quelpa 'smex)
(quelpa 'ido-hacks)

(require 'ido-ubiquitous)
(require 'ido-hacks)

(ido-vertical-mode 1)
(ido-hack-mode 1)
(ido-mode t)
(ido-ubiquitous-initialize)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

;;; flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(setq flx-ido-threshhold 12000)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
;; set gc threshold to 20mb
(setq gc-cons-threshold 20000000)


(add-hook 'ido-minibuffer-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "M-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "M-p") 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)))
