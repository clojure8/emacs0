;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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

(use-package anzu )
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

(use-package flycheck :defer t)

(use-package consult-flycheck :after (consult flycheck))

(use-package puni
  :hook ((prog-mode sgml-mode nxml-mode tex-mode eval-expression-minibuffer-setup) . puni-mode))

(setq mark-ring-max 100)
(setq global-mark-ring-max 100)
(defun xah-pop-local-mark-ring ()
  "Move cursor to last mark position of current buffer.
Call this repeatedly will cycle all positions in `mark-ring'.
URL `http://xahlee.info/emacs/emacs/emacs_jump_to_previous_position.html'
Version 2016-04-04"
  (interactive)
  (set-mark-command t))
(global-set-key (kbd "<f7>") 'pop-global-mark)
(global-set-key (kbd "<f8>") 'xah-pop-local-mark-ring)
