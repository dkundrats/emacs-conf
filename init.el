;; Add the custom config directory to the load path
(add-to-list 'load-path "~/.emacs.d/config")

(load "config-dape")               ;; Load configuration for DAP (Debug Adapter Protocol)
(load "config-general")            ;; Load general settings and customizations
(load "config-language-server")    ;; Load settings for language server protocol
(load "config-lsp")                ;; Load specific configuration for LSP
(load "config-packages")           ;; Load package management settings
(load "config-projectile")         ;; Load configuration for Projectile (project management)
(load "config-ui-misc")            ;; Load miscellaneous UI customizations
(load "config-gptel.el")             ;; Load GPTEL Azure backend
;; Set the auth sources for authentication
(setq auth-sources '("~/.authinfo")) ;; Specify location of auth info

(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq org-agenda-files '("~/org/sprint.org"))

(require 'ef-themes)

(load-theme 'ef-elea-dark :no-confirm)

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
   '("3d8d455e121653677815b0b5e2f2dacc8581e26bbba9558aa8714f97c524ba0e"
     "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c"
     "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3"
     default))
 '(gdb-many-windows t)
 '(gdb-max-source-window-count 6)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("nongnu" . "http://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(## all-the-icons clang-format clang-format+ counsel
	counsel-projectile dap-mode dape dashboard ef-themes eglot
	eglot-booster elpy flycheck flycheck-rust geiser-mit gptel ivy
	lsp-pyright lsp-ui magit nerd-icons nerd-icons-ivy-rich
	olivetti page-break-lines pdf-tools py-autopep8 py-isort
	pyenv-mode pyvenv rainbow-identifiers rust-mode rustic
	smartparens solarized-theme timu-rouge-theme treemacs
	treemacs-evil treemacs-icons-dired treemacs-persp
	treemacs-projectile treemacs-tab-bar typescript-mode
	use-package vterm vterm-toggle zenburn-theme))
 '(package-vc-selected-packages
   '((eglot-booster :vc-backend Git :url
		    "https://github.com/jdtsmith/eglot-booster.git")))
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

(setq x-super-keysym 'capslock)
