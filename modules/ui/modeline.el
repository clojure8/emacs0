;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package mood-line)

(use-package mini-modeline
  :after mood-line
  :hook (after-init . mini-modeline-mode)
  :config
  ;; Setup flycheck hooks
  (add-hook 'flycheck-status-changed-functions #'mood-line--update-flycheck-segment)
  (add-hook 'flycheck-mode-hook #'mood-line--update-flycheck-segment)

  ;; Setup VC hooks
  (add-hook 'find-file-hook #'mood-line--update-vc-segment)
  (add-hook 'after-save-hook #'mood-line--update-vc-segment)
  (advice-add #'vc-refresh-state :after #'mood-line--update-vc-segment)

  (setq mini-modeline-face-attr 'default)

  (face-spec-set 'mini-modeline-mode-line-inactive
				 '((((background light))
					:background "#d7d9dc" :height 0.1 :box nil)
				   (t
					:background "#444647" :height 0.1 :box nil)))

  (face-spec-set 'mini-modeline-mode-line
				 '((((background light))
					:background "#d7d9dc" :height 0.1 :box nil)
                   (t
					:background "#444647" :height 0.1 :box nil)))

  (defun my/date-info ()
    (format-time-string "[%m-%d %H:%M:%S %a]"))

  (defun my/lsp-mode-segment1 ()
    (assoc 'lsp-mode minor-mode-alist))

  (defun my/eglot-mode ()
	(assoc 'eglot minor-mode-alist))

  (defun my/mood-line-segment-position ()
	"Displays the current cursor position in the mode-line."
	(concat "%l:%c"
			(when mood-line-show-cursor-point (propertize (format ":%d" (point)) 'face 'mood-line-unimportant))
			(propertize " %p  " 'face 'mood-line-unimportant)))

  (defun my/mood-line-segment-minor-mode ()
	(concat (format-mode-line (car mode-name) 'mood-line-major-mode) "  "))

  (setq mood-line-show-encoding-information t
		mood-line-show-eol-style t)

  (setq mini-modeline-l-format
		'(" "
		  (:eval (mood-line-segment-modified))
		  ;; (:eval (mood-line-segment-buffer-name))
		  (:eval " ")
		  (:eval (buffer-name))
		  (:eval "  ")
		  (:eval (mood-line-segment-anzu))
		  (:eval (mood-line-segment-multiple-cursors))
		  (:eval (my/mood-line-segment-position))
		  ;; (:eval (list (nyan-create)))
		  ;; (:eval (parrot-create))
		  ))
  (setq mini-modeline-r-format
		'(
		  (:eval (my/lsp-mode-segment1))
		  (:eval "  ")
		  (:eval (mood-line-segment-eol))
          (:eval (mood-line-segment-encoding))
          (:eval (mood-line-segment-vc))
          (:eval (mood-line-segment-major-mode))
          (:eval (mood-line-segment-misc-info))
          (:eval (mood-line-segment-flycheck))
          ;; (:eval (mood-line-segment-flymake))
          (:eval (mood-line-segment-process))
		  (:eval (my/date-info))
          " ")))

(use-package hide-mode-line :commands (hide-mode-line-mode))

