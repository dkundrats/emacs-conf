(use-package direnv
  :ensure t
  :config
  (direnv-mode)
  (setq direnv-always-show-summary nil))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable t)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  ;; Enable LSP mode for specific languages
  (add-to-list 'lsp-language-id-configuration '(c-mode . "c"))
  (add-to-list 'lsp-language-id-configuration '(python-mode . "python"))
  (add-to-list 'lsp-language-id-configuration '(yaml-mode . "yaml-language-server"))
  ;; Configure LSP servers
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("emacs-lsp-booster" "--" "clangd"))
                    :major-modes '(c-mode)
                    :server-id 'clangd))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("node" "/home/david/Downloads/git/yaml-language-server/out/server/src/server.js" "--stdio"))
    :major-modes '(yaml-mode)
    :server-id 'yaml-language-server))
  (lsp-register-client
   (make-lsp-client 
    :new-connection (lsp-stdio-connection '("pyright-langserver" "--stdio"))
    :activation-fn (lsp-activate-on "python")
    :major-modes '(python-mode)
    :environment-fn (lambda () 
                      (let ((env process-environment))
                        (direnv-update-directory-environment)
                        env))
    :server-id 'pyright
    :multi-root nil
 :priority 1))
 
  (setq lsp-disabled-clients '(jedi)))

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable t))

(defun disable-flycheck-in-rust-mode ()
  (flycheck-mode -1))

(add-hook 'rust-mode-hook #'disable-flycheck-in-rust-mode)
(setq lsp-pyright-typechecking-mode "basic")
(setq lsp-pyright-multi-root nil)
(setq lsp-pyright-use-library-code-for-types t)
(setq lsp-pyright-venv-path nil)
(setq rustic-analyzer-command '("emacs-lsp-booster -- ~/.cargo/bin/rust-analyzer"))

;; DAP mode for debugging
(use-package dap-mode
  :ensure t
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (dap-ui-controls-mode 1)
  (require 'dap-chrome)
  (require 'dap-node))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(defun show-static-lsp-doc ()
  "Show LSP documentation for thing at point in a static buffer."
  (interactive)
  (if (fboundp 'lsp-describe-thing-at-point)
      (lsp-describe-thing-at-point)
    (message "LSP mode not available")))

;; Force LSP to restart with new environment
(defun my/restart-lsp-with-current-env ()
  "Kill LSP session and restart with current environment."
  (interactive)
  (when lsp-mode
    (lsp-workspace-shutdown (lsp-workspaces))
    (lsp)))

;; Hook to apply when changing buffers or directories
(add-hook 'hack-local-variables-hook
          (lambda ()
            (when (and (derived-mode-p 'python-mode)
                       (buffer-file-name))
              (direnv-update-directory-environment)
              (my/restart-lsp-with-current-env))))
;; Add a function that runs when switching buffers
(defun my/check-python-env-change ()
  "Check if Python buffer changed directories and restart LSP if needed."
  (when (and (derived-mode-p 'python-mode)
             (buffer-file-name)
             lsp-mode)
    (let ((current-dir (file-name-directory (buffer-file-name)))
          (workspace-dir (lsp-workspace-root)))
      (unless (string-prefix-p workspace-dir current-dir)
        (direnv-update-directory-environment)
        (lsp-workspace-restart)))))

(defun my/lsp-reset-python-env ()
  "Force reset of Python LSP with current environment."
  (interactive)
  (direnv-update-directory-environment)
  (lsp-restart-workspace))

(global-set-key (kbd "C-c r") #'my/lsp-reset-python-env)
;; Add to focus hooks to detect project changes
(add-hook 'buffer-list-update-hook #'my/check-python-env-change)
;; Automatically start LSP in Python mode
(add-hook 'python-mode-hook #'lsp-deferred)
(global-set-key (kbd "C-c d") 'show-static-lsp-doc)
(global-set-key (kbd "C-c e l d") 'eldoc-doc-buffer)
