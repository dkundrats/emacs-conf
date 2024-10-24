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
