;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package mood-line :defer t)
;; :hook (after-init . mood-line-mode))

(use-package hide-mode-line :commands (hide-mode-line-mode))

(use-package awesome-tray
  :load-path "~/elisp/awesome-tray"
  :config
  (defvar-local my--vc-text nil)
  (defun my/vc-info (&rest _)
	"Update `my--vc-text' against the current VCS state."
	(setq my--vc-text
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
						""))))))
  ;; Setup VC hooks
  (add-hook 'find-file-hook #'my/vc-info)
  (add-hook 'after-save-hook #'my/vc-info)
  (advice-add #'vc-refresh-state :after #'my/vc-info)

  (defvar-local my--flycheck-text nil)
  (defun my/flycheck-info (&optional status)
	"Update `my--flycheck-text' against the reported flycheck STATUS."
	(setq my--flycheck-text
          (pcase flycheck-last-status-change
			('finished (if flycheck-current-errors
						   (let-alist (flycheck-count-errors flycheck-current-errors)
							 (let ((sum (+ (or .error 0) (or .warning 0))))
							   (propertize (concat "⚑ Issues: "
												   (number-to-string sum)
												   " ")
										   'face (if .error
													 'mood-line-status-error
												   'mood-line-status-warning))))
						 (propertize "✓ Good " 'face 'mood-line-status-success)))
			('running (propertize "Δ Checking " 'face 'mood-line-status-info))
			('errored (propertize "✗ Error " 'face 'mood-line-status-error))
			('interrupted (propertize "⏸ Paused " 'face 'mood-line-status-neutral))
			('no-checked ""))))

  ;; Setup flycheck hooks
  (add-hook 'flycheck-status-changed-functions #'my/flycheck-info)
  (add-hook 'flycheck-mode-hook #'my/flycheck-info)

  (defun my/lsp-mode-info () (assoc 'lsp-mode minor-mode-alist))

  (defun my/encode-info ()
	(concat (let ((sys (coding-system-plist buffer-file-coding-system)))
              (cond ((memq (plist-get sys :category) '(coding-category-undecided coding-category-utf-8))
                     "UTF-8")
                    (t (upcase (symbol-name (plist-get sys :name))))))))

  (defun my/eol-info ()
	(pcase (coding-system-eol-type buffer-file-coding-system)
	  (0 "LF")
	  (1 "CRLF")
	  (2 "CR")))

  (add-to-list 'awesome-tray-module-alist '("lsp" . (my/lsp-mode-info awesome-tray-module-evil-face)))
  (add-to-list 'awesome-tray-module-alist '("eol" . (my/encode-info awesome-tray-module-evil-face)))
  (add-to-list 'awesome-tray-module-alist '("encode" . (my/eol-info awesome-tray-module-awesome-tab-face)))
  (add-to-list 'awesome-tray-module-alist '("vc" . (my/vc-info awesome-tray-module-evil-face)))
  (add-to-list 'awesome-tray-module-alist '("flycheck" . (my/flycheck-info )))

  (setq awesome-tray-active-modules '("evil" "lsp" "file-path" "mode-name" "eol" "encode" "flycheck" "vc" "date"))
  (awesome-tray-mode)
  )
