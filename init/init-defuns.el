(provide 'init-defuns)

(quelpa 'dash)
(quelpa 's)
(eval-after-load "dash" '(dash-enable-font-lock))

(defun duplicate-region ()
  (interactive)
  (kill-region (region-beginning) (region-end))
  (yank)
  (vhl/clear-all)
  (yank))

(defun ido-find-file-in-project-root ()
  (interactive)
  (ido-find-file-in-dir (projectile-project-root)))


(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (vhl/clear-all)
  (yank))

(defun clean-up-buffer-or-region ()
  "Untabifies, indents and deletes trailing whitespace from buffer or region."
  (interactive)
  (save-excursion
    (unless (region-active-p)
      (mark-whole-buffer))
    (untabify (region-beginning) (region-end))
    (indent-region (region-beginning) (region-end))
    (save-restriction
      (narrow-to-region (region-beginning) (region-end))
      (delete-trailing-whitespace))))


(defun newline-anywhere ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun newline-on-previous-line-anywhere ()
  (interactive)
  (previous-line)
  (end-of-line)
  (newline-and-indent))

(defun current-line-number ()
  (+ 1 (count-lines 1 (point))))

(defun send-current-line-to-next-window ()
  "Send current line to next window"
  (interactive)
  (let ((current-line (buffer-substring-no-properties (point-at-bol) (point-at-eol)))
        (target (window-buffer (next-window))))
    (with-current-buffer target
      (insert current-line))))

(defun reset-current-dir ()
  (interactive)
  (let ((dir (file-name-directory (buffer-file-name))))
    (cd dir)
    (message (concat "Set the current buffer directory to " dir))))

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun my-delete-backwards ()
  (interactive)
  (delete-region (point) (progn (evil-backward-word-begin) (point))))

(defun add-to-js-globals ()
  (interactive)
  (let ((var (word-at-point)))
    (save-excursion
      (goto-char (point-min))
      (when (not (string-match "^/\\*global " (current-line)))
        (newline)
        (forward-line -1)
        (insert "/*global */"))
      (while (not (string-match "*/" (current-line)))
        (next-line))
      (end-of-line)
      (delete-char -2)
      (insert (concat var " */")))))

(defun new-line-in-normal-mode ()
  "make a new line without moving the cursor or leaving normal mode"
  (interactive)
  (save-excursion
    (evil-insert-newline-below)
    (evil-force-normal-state)))

(defun semi-colonize ()
  (interactive)
  (goto-char (point-min))
  (query-replace-regexp "^ *[^/]+[^;,{}\n.]$" "\\&;"))

(defun format-json ()
  (interactive)
  (let ((cmd "python -mjson.tool"))
    (shell-command-on-region (region-beginning) (region-end) cmd nil t)))

(defun copy-to-end-of-line ()
  (interactive)
  (copy-region-as-kill (point) (point-at-eol)))

(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (if (get-buffer new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (rename-file name new-name 1)
        (rename-buffer new-name)
        (set-visited-file-name new-name)
        (set-buffer-modified-p nil)))))


(defun fix-buffer-directory ()
  (interactive)
  (if buffer-file-name
      (setq default-directory
            (file-name-directory buffer-file-name))))

(defun switch-to-local-project ()
  (interactive)
  (let* ((prompt "Switch to project: ")
         (project-dir "~/src")
         (choices (actionable-files-in-directory project-dir))
         (project (ido-completing-read prompt choices nil t)))

    (find-file (concat project-dir "/" project))))

(defun actionable-files-in-directory (dir)
  (let ((files (directory-files dir))
        (blacklist '(".DS_Store" "." "..")))
    (-difference files blacklist)))


(defmacro allow-line-as-region-for-function (orig-function)
  `(defun ,(intern (concat (symbol-name orig-function) "-or-line"))
       ()
     ,(format "Like `%s', but acts on the current line if mark is not active."
              orig-function)
     (interactive)
     (if mark-active
         (call-interactively (function ,orig-function))
       (save-excursion
         ;; define a region (temporarily) -- so any C-u prefixes etc. are preserved.
         (beginning-of-line)
         (set-mark (point))
         (end-of-line)
         (call-interactively (function ,orig-function))))))

(allow-line-as-region-for-function comment-or-uncomment-region)

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))

         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2)))
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun create-scratch-buffer ()
  "create a new scratch buffer to work in. (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
        bufname)
    (while (progn
             (setq bufname (concat "*scratch"
                                   (if (= n 0) "" (int-to-string n))
                                   "*"))
             (setq n (1+ n))
             (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (emacs-lisp-mode)))

(defun only-current-buffer ()
  (interactive)
    (mapc 'kill-buffer
          (-filter
           (lambda (buf) (not (s-starts-with? "*" (buffer-name buf))))
           (cdr (buffer-list (current-buffer))))))
