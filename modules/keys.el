;; -*- coding: utf-8; lexical-binding: t; -*-

;;; code:
(use-package general
  :init
  (setq general-override-states '(insert
                                  emacs
                                  hybrid
                                  normal
                                  visual
                                  motion
                                  operator
                                  replace))
  :config
  (general-define-key
   :states '(normal visual motion)
   :keymaps 'dired-mode-map
   :keymaps 'override
   "RET" 'dired-find-file)

  (general-define-key
   :states '(normal visual motion)
   :keymaps 'override
   "M-p" 'consult-buffer
   "s-p" 'consult-buffer
   "M-z" 'evil-undo
   "M-x" 'execute-extended-command
   "s-x" 'execute-extended-command
   "M-v" 'evil-paste-after
   "s-/" 'comment-line
   "M-/" 'comment-line
   "M-f" 'consult-line
   "C-S-p" 'consult-buffer
   "M-s" 'save-buffer
   "s-;" 'yas-expand
   "C-x k" 'kill-current-buffer
   "C-c g" 'golden-ratio
   "C-c C-c" 'er/expand-region)

  (general-create-definer g-leader-def
    :states '(normal insert visual emacs)
    :prefix "g"
    :non-normal-prefix "C-;")

  (g-leader-def
    "l" 'awesome-tab-forward-tab
    "h" 'awesome-tab-backward-tab
    "k" 'awesome-tab-forward-group
    "j" 'awesome-tab-backward-group)

  (general-create-definer spc-leader-def
    :states '(normal insert visual emacs)
    :prefix "<SPC>"
    :non-normal-prefix "C-,")
  (spc-leader-def
    "SPC" 'execute-extended-command
	"wu" 'xwidget-webkit-browse-url
	"wh" 'xwidget-webkit-back
	"wl" 'xwidget-webkit-forward
	"ws" 'xwidget-webkit-browse-history

	"wo" 'ace-window
    "ht" 'consult-theme
    "ep" 'treemacs-display-current-project-exclusively
    "op" 'treemacs
    "br" 'revert-buffer
    "ys" 'consult-yasnippet
    "oc" 'org-capture
    "fr" 'consult-recent-file
    "bb" 'consult-buffer
    "bl" 'evil-switch-to-windows-last-buffer
    "ff" 'find-file
    "fs" 'swiper
    "bk" 'kill-current-buffer
    "gs" 'magit-status
    "gg" 'magit-status
    "gd" 'magit-dispatch
    "rc" 'anzu-replace-at-cursor-thing
    "ra" 'anzu-query-replace-at-cursor
    "pf" 'consult-projectile-find-file
    "fp" 'consult-projectile-find-file
    "pp" 'consult-projectile-switch-project
    "pa" 'projectile-add-known-project
    "pr" 'consult-ripgrep
	"pg" 'consult-git-grep
    "jj" 'dumb-jump-go
    "jb" 'dumb-jump-back
    "bu" 'xwidget-webkit-browse-url
	"wu" 'winner-undo
	"wr" 'winner-redo
	"wc" 'eyebrowse-create-window-config
	"wm" 'eyebrowse-last-window-config

	"hf" 'describe-function
	"hv" 'describe-variable
	"ha" 'describe-face
	))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :hook
  (after-init . evil-mode))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init '(calendar magit calc ediff org vterm)))
