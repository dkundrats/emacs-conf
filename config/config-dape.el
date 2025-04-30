(use-package dape
  :ensure t)

(add-to-list 'dape-configs
             `(debugpy
               modes (python-ts-mode python-mode)
               command "python"
               command-args ("-m" "debugpy.adapter")
               :type "executable"
               :request "launch"
               :cwd dape-cwd-fn
               :program dape-buffer-default))

(add-to-list 'dape-configs
             '(debugpy-attach-port
               modes (python-mode python-ts-mode)
               port (lambda () (read-number "Port: "))
               :request "attach"
               :type "python"
               :justMyCode nil
               :showReturnValue t))

(add-to-list 'dape-configs
             '(gdb-rust
               modes (rust-mode rustic-mode)
               command "gdb"
               command-args ("-i=mi" "--interpreter=mi2")
               command-cwd (lambda () default-directory)
               target (lambda () 
                        (let ((target-dir (concat (locate-dominating-file default-directory "Cargo.toml")
                                                 "target/debug/")))
                          (expand-file-name
                           (concat target-dir
                                  (file-name-base
                                   (directory-file-name
                                    (locate-dominating-file default-directory "Cargo.toml")))))))
               :type "gdb"
               :request "launch"))
