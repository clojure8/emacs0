;; -*- coding: utf-8; lexical-binding: t; -*-

(setq-default cursor-type '(bar . 2))

;;; emacs settings
(setq-default auto-save-default nil	   ; disable auto save
			  truncate-lines nil
			  create-lockfiles nil
			  tab-width 4
			  auto-window-vscroll nil
			  ns-use-proxy-icon nil  ; hide titlebar icon
			  delete-by-moving-to-trash t  ; disable delete directly
			  fast-but-imprecise-scrolling t
			  frame-title-format nil
			  help-window-select t
			  inhibit-startup-screen t	   ; disable the startup screen splash
			  ;; inhibit-default-init t
			  initial-scratch-message nil
			  inhibit-compacting-font-caches t
			  make-backup-files nil             ; disable backup file
			  ;; Mouse wheel scroll behavior
			  ;; mouse-wheel-scroll-amount '(1 ((shift) . 1))
			  mouse-wheel-progressive-speed nil
			  mouse-wheel-follow-mouse t
			  next-line-add-newlines nil
			  read-process-output-max (* 64 1024)
			  visible-bell nil
			  ring-bell-function 'ignore

			  confirm-kill-emacs 'yes-or-no-p                  ; Confirm before exiting Emacs

			  ;; left-margin-width 1
			  ;; right-margin-width 1         ; Add left and right margins

			  mode-require-final-newline 'visit                ; Add a newline at EOF on visit
			  mouse-yank-at-point t                            ; Yank at point rather than pointer
			  ns-use-srgb-colorspace nil                       ; Don't use sRGB colors
			  recenter-positions '(5 top bottom)               ; Set re-centering positions
			  redisplay-dont-pause t                           ; don't pause display on input
			  debug-on-error t
			  jit-lock-defer-time 0
			  frame-resize-pixelwise t
			  fast-but-imprecise-scrolling t
			  scroll-conservatively 10000
			  scroll-preserve-screen-position t
			  scroll-up-aggressively 0.01
			  scroll-down-aggressively 0.01
			  scroll-margin 1                                  ; scroll N lines to screen edge
			  scroll-step 1                                    ; keyboard scroll one line at a time
			  select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
			  sentence-end-double-space nil                    ; End a sentence after a dot and a space
			  show-trailing-whitespace nil                     ; Display trailing whitespaces
			  split-height-threshold nil                       ; Disable vertical window splitting
			  split-width-threshold nil                        ; Disable horizontal window splitting
			  uniquify-buffer-name-style 'forward              ; Uniquify buffer names
			  window-combination-resize t                      ; Resize windows proportionally
			  ;; x-stretch-cursor t                              ; Stretch cursor to the glyph width
			  )

;;; system coding
;; although others may add many other settings here,
;; but I think the next line is enough
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;; macOS special settings
;; <macOS> Command -> Meta, Option -> Super
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
		mac-option-modifier 'super)
  (global-set-key (kbd "M-a") 'mark-whole-buffer) ;;对应Ctrl-a 全选
  (global-set-key (kbd "M-c") 'kill-ring-save) ;;对应Ctrl-c 复制
  (global-set-key (kbd "M-s") 'save-buffer) ;; 对应Ctrl-s 保存
  (global-set-key (kbd "M-v") 'yank) ;对应Ctrl-v 粘贴
  (global-set-key (kbd "M-z") 'undo) ;对应Ctrol-z 撤销
  (global-set-key (kbd "s-x") 'kill-region) ;对应Ctrol-x 剪
  )

;; 像素滚动
(when (>= emacs-major-version 29)
  (add-hook 'after-init-hook #'pixel-scroll-precision-mode))

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; lambda显示为λ
(add-hook 'prog-mode-hook #'global-prettify-symbols-mode)

;; 中英文中文字体设置
(defun set-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil
		      :font (format   "%s:pixelsize=%d"  english english-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
					  (font-spec :family chinese :size chinese-size))))

(add-hook 'after-init-hook
		  (lambda ()
			;; (set-font "JetBrains Mono" "华文楷体" 13 15)
			;; (set-font "JetBrains Mono" "STkaiti" 13 14)
			;; (set-font "Source Code Pro" "STkaiti" 13 15)
			(setq-default line-spacing 0.108)
			;; (set-font "monospace" "STkaiti" 14 14)
			;; (set-font "Hack" "Stkaiti" 13 15)
			;; (set-font "Monoid" "更纱黑体 SC" 11 13)
			(set-font "Monoid" "更纱黑体 SC" 11 13)
			;; (set-font "" "华文楷体" 11 15)
			(setq visible-bell nil)))

;; 默认打开浏览器设置
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOs/Google Chrome")
;; (setq browse-url-browser-function 'xwidget-webkit-browse-url)

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode))

(use-package exec-path-from-shell
  :commands (exec-path-from-shell-copy-env exec-path-from-shell-initialize)
  :hook (after-init . exec-path-from-shell-initialize)
  )
