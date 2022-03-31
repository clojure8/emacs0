;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :hook (prog-mode . smartparens-mode))
 
(use-package goto-chg :defer t)

(use-package smart-hungry-delete
  :bind (("<backspace>" . smart-hungry-delete-backward-char)
		 ("C-d" . smart-hungry-delete-forward-char))
  :defer nil ;; dont defer so we can add our functions to hooks 
  :config (smart-hungry-delete-add-default-hooks))

(use-package multiple-cursors :defer t)

(use-package drag-stuff
  :config
  (drag-stuff-global-mode +1)
  (drag-stuff-define-keys))

(use-package expand-region
  :config
  (global-set-key (kbd "M-=") 'er/expand-region))

(use-package anzu :defer t)
(use-package evil-anzu :defer t)

(use-package ws-butler
  :hook (prog-mode . ws-butler-mode))

(use-package dumb-jump :defer t)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package wgrep
  :defer t
  :init
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-change-readonly-file t))

(use-package flycheck
  :hook (prog-mode . global-flycheck-mode))

(use-package consult-flycheck :after (consult flycheck))
