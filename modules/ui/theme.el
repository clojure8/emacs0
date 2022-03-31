;; -*- coding: utf-8; lexical-binding: t; -*-

;;; code:

;; (setq my-theme 'doom-dracula)
;; (setq my-theme 'modus-operandi)
;;(setq my-theme 'modus-vivendi)
;;(setq my-theme 'doom-xcode)
;; (setq my-theme 'doom-monokai-pro)
;; (setq my-theme 'doom-one-light)
;; (setq my-theme 'doom-one)
(setq my-theme 'leuven)
;; (setq my-theme 'leuven-dark)
;; (setq my-theme 'doom-plain)
;; (setq my-theme 'kaolin-light)
;; (defvar my-theme nil "my theme")

(use-package doom-themes
  :custom-face
  (magit-header-line ((t (:inherit 'mode-line))))
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (add-hook 'after-init-hook (lambda () (load-theme my-theme t)))
  (doom-themes-org-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config))

;; (use-package chocolate-theme :defer t)
;; (use-package tron-legacy-theme :defer t)
;; (use-package sublime-themes :defer t)
(use-package kaolin-themes :defer t)
;; (use-package modus-themes :defer t)
