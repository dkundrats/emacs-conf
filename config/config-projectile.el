;; projectile install and key mappings
(use-package projectile
  :ensure t
  :custom (projectile-completion-system 'ivy)
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))
