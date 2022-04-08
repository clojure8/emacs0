;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package magit :defer t)

(use-package all-the-icons :defer t)

(use-package vterm :defer t
  :hook (vterm-mode . turn-off-evil-mode))

(use-package crux :defer t)

;; (use-package dtache
;;   :commands (dtache-eshell-send-input dtache-shell-command)
;;   :config
;;   (dtache-shell-setup))

(use-package devdocs :defer t)
(use-package avy :defer t)

(use-package link-hint
  :defer t
  :bind
  ("C-c l o" . link-hint-open-link)
  ("C-c l c" . link-hint-copy-link)
  :config
  (setq browse-url-browser-function 'browse-url-chromium))

(use-package which-key :defer t)

;; (use-package format-all :defer t)

(use-package go-translate
  :commands
  (gts-do-translate)
  :config
  ;; 配置多个翻译语言对
  (setq gts-translate-list '(("en" "zh") ("fr" "zh")))

  ;; 配置默认的 translator
  ;; 这些配置将被 gts-do-translate 命令使用
  (setq gts-default-translator
		(gts-translator

		 :picker ; 用于拾取初始文本、from、to，只能配置一个

		 ;;(gts-noprompt-picker)
		 ;;(gts-noprompt-picker :texter (gts-whole-buffer-texter))
		 (gts-prompt-picker)
		 ;;(gts-prompt-picker :single t)
		 ;;(gts-prompt-picker :texter (gts-current-or-selection-texter) :single t)

		 :engines ; 翻译引擎，可以配置多个。另外可以传入不同的 Parser 从而使用不同样式的输出
		 (list
          (gts-bing-engine)
          ;;(gts-google-engine)
          ;;(gts-google-rpc-engine)
          ;;(gts-deepl-engine :auth-key [YOUR_AUTH_KEY] :pro nil)
          (gts-google-engine :parser (gts-google-summary-parser))
          ;;(gts-google-engine :parser (gts-google-parser))
          ;;(gts-google-rpc-engine :parser (gts-google-rpc-summary-parser))
          (gts-google-rpc-engine :parser (gts-google-rpc-parser))
          )

		 :render ; 渲染器，只能一个，用于输出结果到指定目标。如果使用 childframe 版本的，需自行安装 posframe

		 (gts-buffer-render)
		 ;; (gts-posframe-pop-render)
		 ;;(gts-posframe-pop-render :backcolor "#333333" :forecolor "#ffffff")
		 ;;(gts-posframe-pin-render)
		 ;;(gts-posframe-pin-render :position (cons 1200 20))
		 ;;(gts-posframe-pin-render :width 80 :height 25 :position (cons 1000 20) :forecolor "#ffffff" :backcolor "#111111")
		 ;;(gts-kill-ring-render)
		 ))
  )

(use-package undo-fu
  :commands (undo-fu-only-undo undo-fu-only-redo)
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package undo-fu-session
  :after undo-fu
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (global-undo-fu-session-mode +1))


(defun my/align-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))
