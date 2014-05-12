;; Author: akorobov@gmail.com

;; Provides on-the-fly java syntax checking using flycheck or flymake.
;; Supports standard or custom java project directory structure
;; Automatially picks up eclipse project definition (if available)
;; Uses eclipse batch compiler for syntax checking (invoked directly of via drip)
;; Uses drip (https://github.com/flatland/drip) if available

;; Can be used with both flycheck and flymake
;; Requires flycheck version 0.10 (83aac8b326) or later

(require 'xml)

(defconst jsc/eclipse-project-file-name ".project")
(defconst jsc/lisp-project-file-name ".project.el")

;; by default java compiler tries to build transitive closure of source code
;; (all referenced classes) so in large codebases running compiler and parsing
;; errors takes way too much time/resources. no-sourcepath variable controls
;; inclusion of source directories into compiler command. when it is set
;; compiler is given only current classpath (where compiled classes reside).
;; This speeds up compilation/syntax checking at expense of running on possibly
;; stale data.
(defvar jsc/no-sourcepath t)

(defvar jsc/ecj-jar-path
  (expand-file-name  "~/dev/tools/ecj-4.2.jar")
  "Location of ecj batch compiler jar")

(defconst jsc/default-java-project
  '((:source . "1.6")
    (:target . "1.6")
    (:options . "-warn:+over-ann,uselessTypeCheck -proceedOnError -maxProblems 100")
    ;; source code -> class path mappings
    (:paths . (("src/main/java" . "target/classes")
              ("src/test/java" . "target/test-classes")))
    ;; library paths to check
    (:lib-paths . ("lib" "target/dependency")))
    "Standard java project definition")

(defvar jsc/java
  (let ((drip (executable-find "drip")))
    (if drip
        drip
      "java"))
    "Use drip if available, otherwise java")

(defun jsc/save-project ()
  (interactive)
  "Saves project definition in file "
  (when (local-variable-p 'current-java-project)
    (let ((proj-file-name (jsc/write-project-def jsc/lisp-project-file-name current-java-project)))
      ((match-end N)ssage "Saved project definition to %S" proj-file-name))))

(defun jsc/reset
  (interactive)
  "Clears current java syntax checker state and causes project definition to be re-read during next check"
  (kill-local-variable 'current-java-project)
  (kill-local-variable 'compiler-cmd-options))

(defun jsc/read-project ()
  (interactive)
  "Re-reads java project definition for current buffer"
  (kill-local-variable 'current-java-project)
  (jsc/get-ecj-compiler-options))

(defun jsc/write-project-def (fname project)
  (let ((proj-file-name (concat (cdr (assoc ':project-dir project)) fname)))
    (with-temp-file proj-file-name
      (insert (let ((print-length nil))
                (pp-to-string project)))
      proj-file-name)))

(defun jsc/read-project-def (dir)
  (let ((root-dir (locate-dominating-file dir jsc/lisp-project-file-name)))
    (if root-dir
        (read (with-temp-buffer
                (insert-file-contents (concat root-dir jsc/lisp-project-file-name))
                (buffer-string)))
      nil)))

(defun jsc/get-abs-path (p e) (expand-file-name (concat p "/" e)))
(defun jsc/parse-eclipse-classpath (cp-file)
  (if cp-file
      (let* ((classpath-entries (xml-get-children (car (xml-parse-file cp-file)) 'classpathentry))
             (paths ())
             (libs ()))
        (mapc (lambda (e)
                (let* ((attrs (xml-node-attributes e))
                       (path (cdr (assq 'path attrs)))
                       (output (cdr (assq 'output attrs)))
                       (kind (cdr (assq 'kind attrs))))
                  (cond ((string= "src" kind)
                        (add-to-list 'paths (cons path output)))
                        ((string= "lib" kind)
                         (add-to-list 'libs path))))) classpath-entries)
        (list (cons ':paths paths) (cons 'libs libs)))
      ))

(defun jsc/read-eclipse-project (dir)
  (let ((ecp (jsc/parse-eclipse-classpath (concat dir  "/.classpath"))))
    ;; create new project assoc list
    (list (cons ':project-dir dir)
          (assoc :source jsc/default-java-project)
          (assoc ':target jsc/default-java-project)
          (assoc ':options jsc/default-java-project)
          (assoc ':paths ecp)
          (assoc 'libs ecp))))

;; custom error parser is required to parse error/warning column
(defun jsc/ecj-compile-pattern (s level)
  (list (concat "^\\(?1:.*\\):\\(?2:[0-9]+\\): " s ": +\\(?4:.*\\)$") level))

;; returns tuple of type and root directory of the project
(defun jsc/find-project (dir)
  (let ((eclipse-dir (locate-dominating-file dir jsc/eclipse-project-file-name))
        (fmj-dir (locate-dominating-file dir jsc/lisp-project-file-name)))
    (if fmj-dir (cons 'lisp fmj-dir)
      (if eclipse-dir (cons 'eclipse eclipse-dir)
        (let* ((paths (cdr (assoc ':paths jsc/default-java-project)))
               ;; match paths that contain either of project source paths
               (pat (concat "\\(.*\\)\\(" (mapconcat #'car paths "\\|") "\\)\\(.*\\)")))
          (if (string-match pat dir)
              (cons 'standard (match-string 1 dir))
            '(unknown . unknown)))
         ))))

(defun jsc/initialize (dir)
  ;; delete defaults
  (let* ((project-info (jsc/find-project dir))
         (root-dir (cdr project-info)))

    (case (car project-info)
      (eclipse (jsc/read-eclipse-project root-dir))
      (lisp
       (cons (cons ':project-dir root-dir)
             (jsc/read-project-def root-dir)))
      (standard (cons
                 (cons ':project-dir root-dir)
                 (copy-alist jsc/default-java-project)))
      (else
       ;; try to guess other common cases
       (error "unable to find root of project")))))


(defun jsc/expand-lib-path (d)
  (let ((absd (expand-file-name d project-dir)))
    (when (file-exists-p absd)
      (mapcar (lambda (e) (concat d "/" e))
              (directory-files absd nil ".*\\(jar\\|zip\\)")))))

(defun jsc/expand-lib-paths (project-dir p)
  (if (assoc 'libs p)
      (cdr (assoc 'libs p))
    (let* ((lib-paths (cdr (assoc ':lib-paths p)))
           (libs (apply #'append (mapcar #'jsc/expand-lib-path lib-paths))))
      libs)))

(defun jsc/make-compiler-options (p)
  (let* ((root (cdr (assoc ':project-dir p)))
         (paths (cdr (assoc ':paths p)))
         (libs (jsc/expand-lib-paths root p))
         (source-path (mapconcat (lambda (e)
                                   (jsc/get-abs-path root (car e))) paths ":"))
         (class-path (mapconcat (lambda (e)
                                  (jsc/get-abs-path root e))
                                (append (mapcar #'cdr paths) libs) ":")))
    (append (list "-source"
                  (cdr (assoc :source p))
                  "-target"
                  (cdr (assoc ':target p))
                  "-classpath" class-path)
            (if jsc/no-sourcepath nil `("-sourcepath" ,source-path)))))

;; flycheck syntax checker
(defun jsc/get-ecj-compiler-options ()
  "pre-computes and stores project definition and checker command line in buffer variables"
  (when (not (local-variable-p 'current-java-project))
    (let* ((p (jsc/initialize default-directory))
           (opts (jsc/make-compiler-options p)))
      ;; project definition with pre-built command line options is kept in current-java-project buffer variable
      (setq-local current-java-project p)
      (setq-local compiler-cmd-options opts)))
  compiler-cmd-options)

(when (featurep 'flycheck-autoloads)
  (flycheck-declare-checker java-syntax
    "Check syntax of java code using ecj compiler"
    :command `(,jsc/java
               "-Xms128m"
               "-Xmx128m"
               "-jar" ,jsc/ecj-jar-path
               "-d" "none"
               "-Xemacs"
               (eval (jsc/get-ecj-compiler-options))
               source)
    :error-patterns
    (list (jsc/ecj-compile-pattern "warning" 'warning)
          (jsc/ecj-compile-pattern "error" 'error))
    :modes '(java-mode))

  (add-to-list 'flycheck-checkers 'java-syntax))

;; check using flymake
(defun jsc/fm-init ()
  "Initialize syntax checker command"
  (let* ((cmd-options (jsc/get-ecj-compiler-options))
         (temp-file (flymake-init-create-temp-buffer-copy
                     'jsc/fm-create-temp-file))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))

    (list jsc/java
          (append (list "-Xms128m"
                        "-Xmx128m"
                        "-jar" jsc/ecj-jar-path
                        "-d" "none"
                        "-Xemacs")
                  cmd-options
                  (list (expand-file-name local-file))))))

(defun jsc/fm-cleanup ()
  "Delete temp file and dirs."
  (flymake-safe-delete-file flymake-temp-source-file-name)
  (when flymake-temp-source-file-name
    (flymake-safe-delete-directory (file-name-directory flymake-temp-source-file-name))))

(defun jsc/fm-create-temp-file (file-name prefix)
  "Create temporary directory file "
  (file-truename (expand-file-name
                  (file-name-nondirectory file-name)
                  (expand-file-name  (int-to-string (abs (random))) (flymake-get-temp-dir)))))

(when (featurep 'flymake)
  (push '(".+\\.java$" jsc/fm-init jsc/fm-cleanup) flymake-allowed-file-name-masks))

(provide 'java-syntax-checker)
