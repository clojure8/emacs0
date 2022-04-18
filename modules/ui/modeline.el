;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

;; (use-package mood-line :defer t)
;; :hook (after-init . mood-line-mode))

(use-package hide-mode-line :commands (hide-mode-line-mode))

(use-package awesome-tray
  :load-path "~/elisp/awesome-tray"
  :config
  (defun my/vc-info (&rest _)
	(when (and vc-mode buffer-file-name)
	  (let ((backend (vc-backend buffer-file-name))
			(state (vc-state buffer-file-name (vc-backend buffer-file-name))))
		(let ((face 'mode-line-neutral))
		  (concat "" (cond ((memq state '(edited added))
							(setq face 'mood-line-status-info)
							(propertize "+ " 'face face))
						   ((eq state 'needs-merge)
							(setq face 'mood-line-status-warning)
							(propertize "⟷ " 'face face))
						   ((eq state 'needs-update)
							(setq face 'mood-line-status-warning)
							(propertize "↑ " 'face face))
						   ((memq state '(removed conflict unregistered))
							(setq face 'mood-line-status-error)
							(propertize "✗ " 'face face))
						   (t
							(setq face 'mood-line-status-info)
							(propertize " " 'face face)))
				  (propertize (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))
							  'face face
							  'mouse-face face)
				  "")))))

  (defun my/flycheck-info (&optional status)
	(pcase flycheck-last-status-change
	  ('finished (if flycheck-current-errors
					 (let-alist (flycheck-count-errors flycheck-current-errors)
					   (let ((sum (+ (or .error 0) (or .warning 0))))
						 (list (concat "⚑ Issues: "
									   (number-to-string sum)
									   "")
							   (if .error
								   mood-line-status-error
								 mood-line-status-warning))))
				   (list "✓ Good" mood-line-status-success)))
	  ('running (list "Δ Checking" mood-line-status-info))
	  ('errored (list "✗ Error" mood-line-status-error))
	  ('interrupted (list "= Paused" mood-line-status-neutral))
	  ('no-checked (list "" mood-line-unimportant))
	  (x (list "" mood-line-unimportant))))

  (defun my/lsp-mode-info () (assoc 'lsp-mode minor-mode-alist))

  (defun my/encode-info ()
	(if (s-contains? "*Minibuf" (buffer-name (current-buffer)))
		""
	  (concat (let ((sys (coding-system-plist buffer-file-coding-system)))
				(cond ((memq (plist-get sys :category) '(coding-category-undecided coding-category-utf-8))
                       "UTF-8")
                      (t (upcase (symbol-name (plist-get sys :name)))))))))

  (defun my/eol-info ()
	(pcase (coding-system-eol-type buffer-file-coding-system)
	  (0 "LF")
	  (1 "CRLF")
	  (2 "CR")
	  (x "")))

  (add-to-list 'awesome-tray-module-alist '("eol" . (my/encode-info awesome-tray-module-file-path-face)))
  (add-to-list 'awesome-tray-module-alist '("encode" . (my/eol-info awesome-tray-module-awesome-tab-face)))
  (add-to-list 'awesome-tray-module-alist '("vc" . (my/vc-info awesome-tray-module-evil-face)))
  (add-to-list 'awesome-tray-module-alist '("flycheck" . my/flycheck-info ))

  (setq awesome-tray-active-modules '("evil" "buffer-name" "file-path" "mode-name" "vc" "encode" "eol" "date"))
  (awesome-tray-mode)
  )
