(provide 'init-prodigy)

(quelpa 'prodigy)
(require 'dash)
(require 's)

(defvar my-source-directory "~/src")

(defun my-source-path (fragment)
  (expand-file-name (concat my-source-directory "/" fragment)))

(push 'prodigy-mode evil-emacs-state-modes)
(push 'prodigy-view-mode evil-normal-state-modes)

(eval-after-load "prodigy"
  '(progn
     (define-key prodigy-mode-map (kbd "SPC") 'prodigy-display-process)
     (setq prodigy-kill-process-buffer-on-stop t)))

(defun is-prodigy-buffer-p (buffer-name)
  (s-starts-with? "*prodigy-" buffer-name))



(add-hook 'post-command-hook
          (lambda ()
            (let ((prodigy-buffers (-filter 'is-prodigy-buffer-p
                                            (mapcar (function buffer-name)
                                                    (buffer-list)))))
              (-each prodigy-buffers 'scroll-buffer-to-bottom-when-inactive))))

(prodigy-define-tag :name 'nuvango)

(prodigy-define-service :name "Vincent"
  :command "unicorn"
  :args '("-c" "../../unicorn/dev.rb")
  :path `(,(my-source-path "image_server/bin"))
  :cwd (my-source-path "image_server")
  :ready-message "worker=2 ready")

(prodigy-define-service :name "Vincent single"
  :command "unicorn"
  :args '("-c" "../../unicorn/single.rb")
  :path `(,(my-source-path "image_server/bin"))
  :cwd (my-source-path "image_server")
  :ready-message "worker=2 ready")

(prodigy-define-service
  :name "Vincent rerun"
  :command "bundle"
  :args '("exec" "rerun" "--" "unicorn" "-c" "../../unicorn/dev.rb")
  :path `(,(my-source-path "image_server/bin"))
  :cwd (my-source-path "image_server")
  :tags '(nuvango)
  :ready-message "worker=2 ready")

(prodigy-define-service
  :name "Nuvango"
  :command "bundle"
  :args '("exec" "rails" "server")
  :cwd (my-source-path "spree_gelaskins")
  :tags '(nuvango)
  :ready-message "Listening On")

(prodigy-define-service
  :name "Wrap Browser"
  :command "bundle"
  :args '("exec" "rails" "server" "-p" "8181")
  :cwd (my-source-path "wrap-browser")
  :ready-message "worker=0 ready")

(prodigy-define-service
  :name "Graphite"
  :command "run-graphite-devel-server.py"
  :args '("/opt/graphite")
  :path '("/opt/graphite/bin")
  :cwd "/opt/graphite/bin"
  :tags '(nuvango)
  :ready-message "Quit the server with")

(prodigy-define-service
  :name "Carbon"
  :command "carbon-cache.py"
  :args '("--debug" "start")
  :path '("/opt/graphite/bin")
  :tags '(nuvango)
  :ready-message "ServerFactory")

(prodigy-define-service
  :name "statsd"
  :command "node"
  :args '("stats.js" "localConfig.js")
  :cwd "/opt/statsd"
  :tags '(nuvango)
  :ready-message "server is up")
