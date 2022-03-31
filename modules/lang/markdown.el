;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :config
  (defun +markdown-live-preview-window-xwidget-webkit (file)
	"Preview FILE with xwidget-webkit.
To be used with `markdown-live-preview-window-function'."
	(let ((uri (format "file://%s" file)))
      (xwidget-webkit-browse-url uri)
      xwidget-webkit-last-session-buffer))
  (setq markdown-live-preview-window-function
		'+markdown-live-preview-window-xwidget-webkit))
