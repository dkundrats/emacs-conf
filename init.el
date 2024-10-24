;; Add the custom config directory to the load path
(add-to-list 'load-path "~/.emacs.d/config")

(load "config-dape")               ;; Load configuration for DAP (Debug Adapter Protocol)
(load "config-general")            ;; Load general settings and customizations
(load "config-language-server")    ;; Load settings for language server protocol
(load "config-lsp")                ;; Load specific configuration for LSP
(load "config-packages")           ;; Load package management settings
(load "config-projectile")         ;; Load configuration for Projectile (project management)
(load "config-ui-misc")            ;; Load miscellaneous UI customizations

;; Set the auth sources for authentication
(setq auth-sources '("~/.authinfo")) ;; Specify location of auth info
```
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq org-agenda-files '("~/org/sprint.org"))

;; No sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; warning suppression
(setq warning-minimum-level :emergency)

;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))

;; Don't delete this line.
(package-initialize)
;;(package-refresh-contents)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" default))
 '(gdb-many-windows t)
 '(gdb-max-source-window-count 6)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("nongnu" . "http://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(gptel lsp-ui rustic flycheck-rust py-isort py-autopep8 zenburn-theme rust-mode eglot-booster lsp-pyright counsel-projectile counsel ivy ef-themes dap-mode typescript-mode pdf-tools page-break-lines nerd-icons dashboard all-the-icons elpy smartparens flycheck treemacs-tab-bar treemacs-persp treemacs-icons-dired treemacs-projectile treemacs-evil treemacs vterm-toggle vterm dape rainbow-identifiers olivetti ## magit use-package solarized-theme eglot))
 '(package-vc-selected-packages
   '((eglot-booster :vc-backend Git :url "https://github.com/jdtsmith/eglot-booster")))
 '(warning-suppress-log-types '((comp))))
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "0xProto Nerd Font Mono" :foundry "0xTy" :slant normal :weight regular :height 113 :width normal)))))

