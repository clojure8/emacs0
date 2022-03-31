;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package awesome-tab
  :load-path "~/.emacs.d/etc/elisp/awesome-tab/"
  :custom
  (awesome-tab-height 114)
  (awesome-tab-active-bar-height 20)
  :config
  (defun awesome-tab-buffer-groups ()
	(list (cond
		   ((string-equal "*" (substring (buffer-name) 0 1))
			"Emacs")
		   ((or (s-starts-with? "magit" (buffer-name))
				(s-equals? "COMMIT_EDITMSG" (buffer-name)))
			"magit")
		   (t
			"others"))))
  (awesome-tab-mode t))
