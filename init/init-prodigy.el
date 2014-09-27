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


(prodigy-define-tag :name 'nuvango)
(prodigy-define-tag :name 'clojure)
(prodigy-define-tag :name 'leonardo)

(prodigy-define-service :name "Rabbit"
  :command "rabbit-server"
  :ready-message "completed")

(prodigy-define-service :name "Vincent"
  :command "unicorn"
  :args '("-c" "../../unicorn/vincent/dev.rb")
  :path `(,(my-source-path "vincent/bin"))
  :cwd (my-source-path "vincent")
  :ready-message "worker=2 ready")

(prodigy-define-service :name "Vincent single"
  :command "unicorn"
  :args '("-c" "../../unicorn/vincent/single.rb")
  :path `(,(my-source-path "vincent/bin"))
  :cwd (my-source-path "vincent")
  :ready-message "worker=2 ready")

(prodigy-define-service
  :name "Vincent rerun"
  :command "bundle"
  :args '("exec" "rerun" "--" "unicorn" "-c" "../../unicorn/vincent/dev.rb")
  :path `(,(my-source-path "vincent/bin"))
  :cwd (my-source-path "vincent")
  :tags '(nuvango leonardo)
  :ready-message "worker=2 ready")

(prodigy-define-service
  :name "Nuvango"
  :command "bundle"
  :args '("exec" "unicorn" "-c" "../../unicorn/nuvango/dev.rb")
  :cwd (my-source-path "nuvango")
  :tags '(nuvango)
  :ready-message "worker=2 ready")

(prodigy-define-service
  :name "Nuvango Zeus"
  :command "zeus"
  :args '("start")
  :cwd (my-source-path "nuvango")
  :tags '(nuvango)
  :ready-message "worker=2 ready")

(prodigy-define-service
  :name "Nuvango QA"
  :command "bundle"
  :args '("exec" "unicorn" "--env" "qa" "-c" "../../unicorn/nuvango/qa.rb")
  :cwd (my-source-path "nuvango"))

(prodigy-define-service
  :name "Rabbit"
  :command "rabbitmq-server"
  :tags '(leonardo))

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
  :name "mattbriggs.net"
  :command "bundle"
  :args '("exec" "rake" "preview")
  :cwd (my-source-path "mattbriggs.net")
  :ready-message "Compass is watching for changes. Press Ctrl-C to Stop"
  :env '(("LANG" "en_US.UTF-8")
         ("LC_ALL" "en_US.UTF-8")))

(prodigy-define-service
  :name "Schmetterling"
  :command "lein"
  :args '("run")
  :tags '(leonardo)
  :cwd (my-source-path "schmetterling")
  :ready-message "Compass is watching for changes. Press Ctrl-C to Stop")

(prodigy-define-service
  :name "statsd"
  :command "node"
  :args '("stats.js" "localConfig.js")
  :cwd "/opt/statsd"
  :tags '(nuvango)
  :ready-message "server is up")
