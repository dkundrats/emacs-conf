
;; maximize frame on start
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; dape
(use-package dape
  :ensure t)
;; warning suppression
(setq warning-minimum-level :emergency)

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
 
(require 'package)
(require 'nerd-icons)
(require 'all-the-icons)
;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))
;; Load emacs packages and activate them
;; This must come before configurations of installed packages.
;; Don't delete this line.
(package-initialize)
;;(load-theme 'modus-vivendi)
(load-theme 'ef-maris-dark t)
;;pdf tools
(pdf-tools-install)  ; Standard activation command
(pdf-loader-install) ; On demand loading, leads to faster startup time
;; projectile install and key mappings
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ed1b7b4db911724b2767d4b6ad240f5f238a6c07e98fff8823debcfb2f7d820a" default))
 '(package-selected-packages
   '(ef-themes nerd-icons dashboard all-the-icons page-break-lines pdf-tools solarized-theme timu-spacegrey-theme copilot quelpa-use-package quelpa editorconfig dape magit treemacs-tab-bar treemacs-persp treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil lsp-jedi flycheck lsp-pyright vterm company lsp-mode treemacs projectile)))
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;all the icons
(use-package dashboard
    :config
        (dashboard-setup-startup-hook)
    :custom
        (dashboard-startup-banner 'logo)
        (dashboard-banner-logo-title nil)
        (dashboard-center-content t)
        (dashboard-icon-type 'all-the-icons)
        (dashboard-set-heading-icons t)
        (dashboard-set-file-icons t)
        (dashboard-set-footer nil)
        (dashboard-projects-backend 'project-el)
        (dashboard-display-icons-p t)
        (dashboard-items '(
            (recents . 5)
            (agenda . 5)
            (projects . 5)
            (bookmarks . 5)
)))
;; dashboard

;;org mode
(require 'org)
;; treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;; turn off that annoying fucking beep
;; No sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; company mode : completion engine
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :custom
  (company-backends '(company-capf)))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))
;; langugae server
(use-package eglot
  :ensure t
  :config
  ;; Associate python-mode with Jedi-language-server
  (add-to-list 'eglot-server-programs '(python-mode . ("jedi-language-server")))
  (add-to-list 'eglot-server-programs '(c-mode . ("ccls"))))

  ;; Any additional configurations for eglot can be placed here
;;vterm 
(use-package vterm
    :ensure t)
;; magit
(use-package magit
  :ensure t)
;; quelpa use package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)
;;python hooks
(defun my-eglot-ensure()
  "Ensure eglot is activated when in relevant programming major modes."
  (eglot-ensure))

(defun my-hs-ensure()
  "Ensure hide show is activate in relevant programming major modes." 
  (hs-minor-mode))

(defun my-python-setup()
  "Ensures: eglot, hide-show"
  (my-hs-ensure)
  (my-eglot-ensure))

(defun my-typescript-setup()
  "Ensures: eglot, hide-show"
  (my-eglot-ensure)
  (my-hs-ensure))

(add-hook 'python-mode-hook #'my-python-setup)
(add-hook 'typescript-mode-hook #'my-typescript-setup)
(add-hook 'js-mode-hook #'my-eglot-ensure)
(add-hook 'c-mode-hook #'my-eglot-ensure)

