;; Ensure packages
(require 'package)
(require 'nerd-icons)
(require 'all-the-icons)

;; quelpa use package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

(use-package nerd-icons :ensure t)
(use-package all-the-icons :ensure t)

;; (use-package dashboard
;;   :ensure t
;;   :init
;;   (setq initial-buffer-choice 'dashboard-open)
;;   :config
;;   (dashboard-setup-startup-hook)
;;    :custom
;;   (dashboard-display-icons-p t)
;;   (dashboard-icon-type 'all-the-icons)
;;   (dashboard-set-heading-icons t)
;;   (dashboard-set-file-icons t)
;;   (dashboard-startup-banner 'logo)
;;   (dashboard-vertically-center-content t)
;;   (dashboard-center-content t)
;;   (dashboard-items '((recents   . 5)
;;                      (agenda    . 5)))
;;   (dashboard-startupify-list '(dashboard-insert-banner
;;                      dashboard-insert-newline
;;                      dashboard-insert-banner-title
;;                      dashboard-insert-init-info
;;                      dashboard-insert-newline
;;                      dashboard-insert-items)))

;; PDF Tools
(pdf-tools-install)
(pdf-loader-install)

;; Projectile
(use-package projectile
  :ensure t
  :custom (projectile-completion-system 'ivy)
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

;; Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))

;; Vterm
(use-package vterm :ensure t)

;; Magit
(use-package magit :ensure t)
(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode))

;; Helm
(use-package helm
  :ensure t
  :config (helm-mode 1))

(pdf-tools-install)  ; Standard activation command
(pdf-loader-install) ; On demand loading, leads to faster startup time

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
;; company mode : completion engine
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :custom
  (company-backends '(company-capf)))

;;vterm
(use-package vterm
    :ensure t)
;; magit
(use-package magit
  :ensure t)

;;git diff
(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode))
(setq magit-diff-refine-hunk t) ; Show word-level diff for the current hunk

;; helm
(use-package helm
  :ensure t
  :config (helm-mode 1))
