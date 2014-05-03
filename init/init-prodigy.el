(provide 'init-prodigy)

(quelpa 'prodigy)

(defvar my-source-directory "~/src")

(defun my-source-path (fragment)
  (expand-file-name (concat my-source-directory "/" fragment)))

(push 'prodigy-mode evil-emacs-state-modes)
(push 'prodigy-view-mode evil-normal-state-modes)

(eval-after-load "prodigy"
  '(define-key prodigy-mode-map (kbd "SPC") 'prodigy-display-process))


(prodigy-define-service
  :name "Vincent"
  :command "puma"
  :args '("-C" "-" "-t" "2:2" "-w" "2" "-p" "4567")
  :path `(,(my-source-path "image_server/bin"))
  :cwd (my-source-path "image_server")
  :ready-message "booted")

(prodigy-define-service
  :name "Vincent -- Shotgun"
  :command "shotgun"
  :args '("-p" "4567")
  :path `(,(my-source-path "image_server/bin"))
  :cwd (my-source-path "image_server")
  :ready-message "Listening")

(prodigy-define-service
  :name "Nuvango"
  :command "bundle"
  :args '("exec" "rails" "server")
  :cwd (my-source-path "spree_gelaskins")
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
  :ready-message "Quit the server with")

(prodigy-define-service
  :name "Carbon"
  :command "carbon-cache.py"
  :args '("--debug" "start")
  :path '("/opt/graphite/bin")
  :ready-message "ServerFactory")

(prodigy-define-service
  :name "statsd"
  :command "node"
  :args '("stats.js" "localConfig.js")
  :cwd "/opt/statsd"
  :ready-message "server is up")
