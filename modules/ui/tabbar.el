;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package awesome-tab
  :load-path "~/elisp/awesome-tab/"
  :custom
  (awesome-tab-height 114)
  (awesome-tab-active-bar-height 20)
  :config
  (defun awesome-tab-buffer-groups ()
	(list (cond
		   ((or (s-starts-with? "*Message" (buffer-name))
				(s-starts-with? "Pfuture" (buffer-name))
				(s-starts-with? "*Warn" (buffer-name))
				(s-starts-with? "*Help" (buffer-name))
				(s-starts-with? "*Backtrace*" (buffer-name)))
			"system-msg")
		   ((or (s-starts-with? "*lsp-ui-imenu" (buffer-name)))
			"lsp-ui-imenu")
		   ((or (s-starts-with? "*dap-ui-sess" (buffer-name)))
			"dap-ui-session")
		   ((or (s-starts-with? "*dap-ui-local" (buffer-name)))
			"dap-ui-local")
		   ((or (s-ends-with? " out*" (buffer-name)))
			"dap-out-log")
		   ((or (s-starts-with? "*dap-ui-repl" (buffer-name)))
			"dap-ui-repl")
		   ((s-starts-with? "*scratch*" (buffer-name))
			"others")
		   ((or (s-starts-with? "magit" (buffer-name))
				(s-equals? "COMMIT_EDITMSG" (buffer-name)))
			"magit")
		   ((or (s-starts-with? "*" (buffer-name)))
			"Emacs")
		   (t
			"others"))))
  (awesome-tab-mode t))

(provide 'init-tabbar)
;;; init-tabbar.el ends here
