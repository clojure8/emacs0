;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

;; (use-package mood-line :defer t)
;;   :hook
;;   (after-init . mood-line-mode))

;; ;; (use-package mini-modeline
;;   :load-path "~/elisp/mini-modeline"
;;   :after mood-line
;;   :hook (after-init . mini-modeline-mode)
;;   :config
;;   ;; Setup flycheck hooks
;;   (add-hook 'flycheck-status-changed-functions #'mood-line--update-flycheck-segment)
;;   (add-hook 'flycheck-mode-hook #'mood-line--update-flycheck-segment)

;;   ;; Setup VC hooks
;;   (add-hook 'find-file-hook #'mood-line--update-vc-segment)
;;   (add-hook 'after-save-hook #'mood-line--update-vc-segment)
;;   (advice-add #'vc-refresh-state :after #'mood-line--update-vc-segment)

;;   (setq mini-modeline-face-attr 'default)

;;   (face-spec-set 'mini-modeline-mode-line-inactive
;; 				 '((((background light))
;; 					:background "#d7d9dc" :height 0.1 :box nil)
;; 				   t
;; 					:background "#444647" :height 0.1 :box nil)))

;;   (face-spec-set 'mini-modeline-mode-line
;; 				 '((((background light))
;; 					:background "#d7d9dc" :height 0.1 :box nil)
;;                    (t
;; 					:background "#444647" :height 0.1 :box nil)))

;;   (defun my/lsp-mode-segment1 ()
;; 	(assoc 'lsp-mode minor-mode-alist))

;;   (defun my/date-info ()
;;     (format-time-string "[%m-%d %H:%M:%S %a]"))

;;   (defun my/eglot-mode ()
;; 	(assoc 'eglot minor-mode-alist))

;;   (defun my/mood-line-segment-position ()
;; 	"Displays the current cursor position in the mode-line."
;; 	(concat "%l:%c"
;; 			(when mood-line-show-cursor-point (propertize (format ":%d" (point)) 'face 'mood-line-unimportant))
;; 			(propertize " %p  " 'face 'mood-line-unimportant)))

;;   (defun my/mood-line-segment-minor-mode ()
;; 	(concat (format-mode-line (car mode-name) 'mood-line-major-mode) "  "))

;;   (setq mood-line-show-encoding-information t
;; 		mood-line-show-eol-style t)

;;   (setq mini-modeline-l-format
;; 		'(" "
;; 		  (:eval (mood-line-segment-modified))
;; 		  ;; (:eval (mood-line-segment-buffer-name))
;; 		  (:eval " ")
;; 		  (:eval (buffer-name))
;; 		  (:eval "  ")
;; 		  (:eval (mood-line-segment-anzu))
;; 		  (:eval (mood-line-segment-multiple-cursors))
;; 		  (:eval (my/mood-line-segment-position))
;; 		  ))
;;   (setq mini-modeline-r-format
;; 		'(
;; 		  (:eval (my/lsp-mode-segment1))
;; 		  (:eval "  ")
;; 		  (:eval (mood-line-segment-eol))
;;           (:eval (mood-line-segment-encoding))
										; (:eval (mood-line-segment-vc))
;;           (:eval (mood-line-segment-major-mode))
;;           (:eval (mood-line-segment-misc-info))
;;           (:eval (mood-line-segment-flycheck))
;; 		  (:eval (mood-line-segment-process))
;; 		  (:eval (my/date-info))
;;           " ")))

(use-package hide-mode-line :commands (hide-mode-line-mode))

(use-package awesome-tray
  :load-path "~/elisp/awesome-tray"
  :config
  ;; Setup VC hooks
  (add-hook 'find-file-hook #'my/vc-info)
  (add-hook 'after-save-hook #'my/vc-info)
  (advice-add #'vc-refresh-state :after #'my/vc-info)

  (defvar-local my--vc-text nil)
  (defun my/vc-info (&rest _)
	"Update `my--vc-text' against the current VCS state."
	(setq my--vc-text
          (when (and vc-mode buffer-file-name)
			(let ((backend (vc-backend buffer-file-name))
                  (state (vc-state buffer-file-name (vc-backend buffer-file-name))))
              (let ((face 'mode-line-neutral))
				(concat (cond ((memq state '(edited added))
                               (setq face 'mood-line-status-info)
                               (propertize "+" 'face face))
                              ((eq state 'needs-merge)
                               (setq face 'mood-line-status-warning)
                               (propertize "⟷" 'face face))
                              ((eq state 'needs-update)
                               (setq face 'mood-line-status-warning)
                               (propertize "↑" 'face face))
                              ((memq state '(removed conflict unregistered))
                               (setq face 'mood-line-status-error)
                               (propertize "✗" 'face face))
                              (t
                               (setq face 'mood-line-status-info)
                               (propertize "" 'face face)))
						(propertize (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))
									'face face
									'mouse-face face)
						""))))))

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
  (add-to-list 'awesome-tray-module-alist '("encode" . (my/encode-info awesome-tray-module-evil-face)))
  (add-to-list 'awesome-tray-module-alist '("eol" . (my/eol-info awesome-tray-module-awesome-tab-face)))
  (add-to-list 'awesome-tray-module-alist '("vc" . (my/vc-info )))

  (setq awesome-tray-active-modules '("evil" "lsp" "buffer-name" "vc" "mode-name" "encode" "eol" "date"))
  (awesome-tray-mode)
  )
