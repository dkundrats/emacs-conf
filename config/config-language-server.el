;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '(c-mode . ("clangd")))
  (add-to-list 'eglot-server-programs '(python-mode . ("jedi-language-server")))
  (add-to-list 'eglot-server-programs
               '(yaml-mode . ("node" "/home/david/Downloads/git/yaml-language-server/out/server/src/server.js" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(typescript-mode . ("/home/david/.nvm/versions/node/v18.20.3/bin/typescript-language-server" "--stdio"))))

(use-package eglot-booster
	:after eglot
	:config	(eglot-booster-mode))

;; false warning suppression
(defun my/eglot-ignore-didChangeWorkspaceFolders-warning (orig-fun category message &rest args)
  "Ignore the 'didChangeWorkspaceFolders' warning from Eglot."
  (unless (and (eq category 'eglot)
               (string-match-p "Server tried to register unsupported capability `workspace/didChangeWorkspaceFolders'" message))
    (apply orig-fun category message args)))

(advice-add 'display-warning :around #'my/eglot-ignore-didChangeWorkspaceFolders-warning)
;;other yaml related things

(use-package yaml-mode
  :ensure t
  :mode ("\\.yaml\\'" "\\.yml\\'"))

;;programming mode hooks
(defun my-eglot-ensure()
  "Ensure eglot is activated when in relevant programming major modes."
  (eglot-ensure))

(defun my-auto-activate-venv ()
  "Automatically activate the venv in the project root."
  (let ((venv-path (locate-dominating-file (buffer-file-name) "venv")))
    (when venv-path
      (pyvenv-activate (expand-file-name "venv" venv-path)))))

(defun my-hs-ensure()
  "Ensure hide show is activate in relevant programming major modes."
  (hs-minor-mode))

(defun my-python-setup()
  "Ensures: eglot, hide-show."
  (my-auto-activate-venv)
  (my-eglot-ensure)
  (my-hs-ensure))

(defun my-typescript-setup()
  "Ensures: eglot, hide-show."
  (my-eglot-ensure)
  (my-hs-ensure))

(defun my-text-setup()
  "Ensures: Olivetti mode."
  (olivetti-mode))

(add-hook 'python-mode-hook 'my-python-setup)
(add-hook 'typescript-mode-hook 'my-typescript-setup)
(add-hook 'js-mode-hook 'my-eglot-ensure)
(add-hook 'text-mode-hook 'my-text-setup)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c-mode-hook 'my-hs-ensure)
