;; -*- coding: utf-8; lexical-binding: t; -*-

;;; Code:
(use-package copilot
  :load-path "~/elisp/copilot/"
  :hook (prog-mode .  copilot-mode)
  :config
  (customize-set-variable 'copilot-enable-predicates '(evil-insert-state-p))

  (defun my-tab ()
	(interactive)
	(or (copilot-accept-completion)
		(company-indent-or-complete-common nil)))

  (with-eval-after-load 'company
	(delq 'company-preview-if-just-one-frontend company-frontends)

	(define-key company-mode-map (kbd "M-/") 'copilot-complete)
	(define-key company-mode-map (kbd "<tab>") 'my-tab)
	(define-key company-mode-map (kbd "TAB") 'my-tab)
	(define-key company-active-map (kbd "<tab>") 'my-tab)
	(define-key company-active-map (kbd "TAB") 'my-tab))
  )

(provide 'init-copilot)
;;; init-copilot.el ends here
