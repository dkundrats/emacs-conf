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
  (add-hook 'lsp-mode-hook)
   ;; Enable LSP mode for specific languages
  (add-to-list 'lsp-language-id-configuration '(c-mode . "clangd"))
  (add-to-list 'lsp-language-id-configuration '(python-mode . "jedi-language-server"))
  (add-to-list 'lsp-language-id-configuration '(yaml-mode . "yaml-language-server"))

  ;; Configure LSP servers
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("clangd"))
                    :major-modes '(c-mode)
                    :server-id 'clangd))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("jedi-language-server"))
                    :major-modes '(python-mode)
                    :server-id 'jedi))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("node" "/home/david/Downloads/git/yaml-language-server/out/server/src/server.js" "--stdio"))
    :major-modes '(yaml-mode)
    :server-id 'yaml-language-server)))

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-enable nil))  ;; Disable sideline if not needed

(defun disable-flycheck-in-rust-mode ()
  (flycheck-mode -1))

(add-hook 'rust-mode-hook #'disable-flycheck-in-rust-mode)
(setq lsp-pyright-typechecking-mode "basic")  ;; Can also be 'off' or 'strict'

;; DAP mode for debugging
(use-package dap-mode
  :ensure t
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (dap-ui-controls-mode 1)
  (require 'dap-chrome)
  (require 'dap-node))
