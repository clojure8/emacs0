;; -*- coding: utf-8; lexical-binding: t; -*-

;;;;;;;;;;; org相关配置
(setq org-directory "~/orgs/")
(setq org-agenda-files '("~/orgs/agenda"))
(setq org-capture-templates '(("d" "工作日报" entry (file+olp+datetree "~/orgs/zeyi/daily.org")
                               "* 日报\n%?\nEntered on %U\n  %i\n")
                              ("a" "添加到TODOs" entry (file+olp+datetree "~/orgs/zeyi/todos.org")
                               "* 每日TODOs\n%?\nEntered on %U\n  %i\n")
                              ("T" "Tickler" entry
                               (file+headline "~/orgs/agenda/tickler.org" "Tickler")
                               "* %i%? \n %U")))
(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode)
  (org-mode . org-indent-mode))

(use-package org-download
  :hook ((org-mode dired-mode) . org-download-enable)
  :config
  (setq-default org-download-image-dir "~/Pictures/foo/")
  (setq-default org-download--dir "~/Pictures/foo/")

  (defun +org-download-method (link)
    (org-download--fullname (org-link-unescape link)))
  (setq org-download-method '+org-download-method)

  (setq org-download-annotate-function (lambda (_link) "")
        org-download-method 'attach
        org-download-screenshot-method "screencapture -i %s"))

(use-package valign
  :hook (org-mode . valign-mode))

(use-package toc-org
  :hook ((markdown-mode . toc-org-mode)
		 (org-mode . toc-org-mode)))

(use-package deft
  :commands (deft)
  :custom
  (deft-extensions '("org" "md" "txt"))
  (deft-directory "~/orgs/")
  (deft-use-filename-as-title t))


(use-package zk
  :after org-mode
  :custom
  (zk-directory "~/orgs/zk")
  (zk-file-extension "org")
  :config
  (require 'zk-consult)
  (zk-setup-auto-link-buttons)
  (zk-setup-embark)
  (setq zk-tag-grep-function #'zk-consult-grep-tag-search
        zk-grep-function #'zk-consult-grep)

  (defun zk-org-try-to-follow-link (fn &optional arg)
	"When 'org-open-at-point' FN fails, try 'zk-follow-link-at-point'.
Optional ARG."
	(let ((org-link-search-must-match-exact-headline t))
      (condition-case nil
		  (apply fn arg)
		(error (zk-follow-link-at-point)))))

  (advice-add 'org-open-at-point :around #'zk-org-try-to-follow-link)

  (defun zk-link-hint--zk-link-at-point-p ()
	"Return the id of the zk-link at point or nil."
	(thing-at-point-looking-at zk-link-regexp))

  (defun zk-link-hint--next-zk-link (&optional bound)
	"Find the next zk-link.
Only search the range between just after the point and BOUND."
	(link-hint--next-regexp zk-id-regexp bound))

  (eval-when-compile
	(link-hint-define-type 'zk-link
      :next #'zk-link-hint--next-zk-link
      :at-point-p #'zk-link-hint--zk-link-at-point-p
      :open #'zk-follow-link-at-point
      :copy #'kill-new))

  (push 'link-hint-zk-link link-hint-types)

  (use-package zk-index
	:after zk
	:config
	(zk-index-setup-embark)
	:custom
	(zk-index-desktop-directory zk-directory))

  (defvar zk-index-map
	(let ((map (make-sparse-keymap)))
      (define-key map (kbd "n") #'zk-index-next-line)
      (define-key map (kbd "p") #'zk-index-previous-line)
      (define-key map (kbd "v") #'zk-index-view-note)
      (define-key map (kbd "o") #'other-window)
      (define-key map (kbd "f") #'zk-index-focus)
      (define-key map (kbd "s") #'zk-index-search)
      (define-key map (kbd "d") #'zk-index-send-to-desktop)
      (define-key map (kbd "D") #'zk-index-switch-to-desktop)
      (define-key map (kbd "S") #'zk-index-desktop-select)
      (define-key map (kbd "c") #'zk-index-current-notes)
      (define-key map (kbd "i") #'zk-index-refresh)
      (define-key map (kbd "M") #'zk-index-sort-modified)
      (define-key map (kbd "C") #'zk-index-sort-created)
      (define-key map (kbd "q") #'delete-window)
      (make-composed-keymap map tabulated-list-mode-map))
	"Keymap for ZK-Index buffer.")
  )

(use-package org-roam
  :commands (org-roam)
  :custom
  (org-roam-directory (file-truename "~/orgs/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package plantuml-mode
  :commands (plantuml-preview)
  :config
  (setq plantuml-executable-path "~/mytools/plantuml/bin/plantuml")
  (setq plantuml-default-exec-mode 'executable))
