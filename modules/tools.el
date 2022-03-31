
(use-package magit :defer t)

(use-package all-the-icons :defer t)
(use-package treemacs :commands (treemacs))


(use-package vterm :defer t)

;; (use-package crux :defer t)

;; (use-package dtache
;;   :commands (dtache-eshell-send-input dtache-shell-command)
;;   :config
;;   (dtache-shell-setup))

(use-package devdocs :defer t)
(use-package avy :defer t)

(use-package link-hint
  :defer t
  :bind
  ("C-c l o" . link-hint-open-link)
  ("C-c l c" . link-hint-copy-link)
  :config
  (setq browse-url-browser-function 'browse-url-chromium))


(use-package which-key :defer t)

;; (use-package format-all :defer t)
