;; Maximize frame on startup
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Display line numbers in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Helm configuration for `imenu`
(global-set-key (kbd "C-c i") 'helm-imenu)
;; gptel send
(global-set-key (kbd "C-c g") 'gptel-send)
(global-set-key (kbd "C-c m") 'gptel-menu)
;; helm find pattern
(global-set-key (kbd "C-c h") 'helm-occur)

;; Org Agenda
(setq org-agenda-files '("~/org/sprint.org"))

;; Suppress warnings
(setq warning-minimum-level :emergency)

;; Disable bell sounds
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))

;; Load Emacs packages and activate them
(package-initialize)

;; Load the theme
;;(load-theme 'zenburn t)

