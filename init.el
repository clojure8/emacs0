;; -*- coding: utf-8; lexical-binding: t; -*-

;; 启动完成的时候显示耗时信息
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; 默认启动目录
(setq default-directory "~/.emacs.d/")

(setq package-user-dir
      (expand-file-name "etc/elpa" user-emacs-directory))

;; 开启守护进程，方便后续emacsclient的快速使用
(add-hook 'after-init-hook #'server-start)
;; 保存窗口布局
(add-hook 'after-init-hook #'winner-mode)
;; (add-hook 'after-init-hook #'desktop-save-mode)

;; -------------------------------------------------
;; 安装包管理。自动安装use-package，省心
;; -------------------------------------------------
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)

  ;;防止反复调用 package-refresh-contents 会影响加载速度
  (when (not package-archive-contents)
	(package-refresh-contents))

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
	(package-install 'use-package))

  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (setq use-package-compute-statistics t))

(use-package no-littering
  :demand
  :config
  (with-eval-after-load 'recentf
  (setq my/etc-directory (expand-file-name "var/config/" user-emacs-directory))
  (setq my/var-directory (expand-file-name "var/data/" user-emacs-directory))
  (add-to-list 'recentf-exclude (expand-file-name "etc/elpa" user-emacs-directory))
  (add-to-list 'recentf-exclude my/etc-directory)
  (add-to-list 'recentf-exclude my/var-directory)))

(add-hook 'after-init-hook 
		  (lambda ()
			;; write over selected text on input... like all modern editors do
			(delete-selection-mode t)
			;; 自动加载修改过的文件
			(global-auto-revert-mode 1)
			(recentf-mode +1)))

(add-hook 'prog-mode-hook  #'hl-line-mode)

(setq auto-save-file-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
(setq custom-file (no-littering-expand-etc-file-name "custom.el"))
(defvar temporary-file-directory "~/.emacs.d/var/tmp")
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))

(use-package esup :defer t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; -------------------------------------------------
;; 自动加载自定的模块（也就是一些配置文件）
;; 只要在~/.emacs.d/modules目录下的全部加载
;; -------------------------------------------------
;; load all modules
(use-package f)

(defvar my-libs-loaded (mapcar #'file-name-sans-extension (delq nil (mapcar #'car load-history))))

(defun load-dir (f my-libs-loaded)
  (dolist (file (directory-files f t ".+\\.el?$"))
    (let ((library (file-name-sans-extension file)))
      (unless (member library my-libs-loaded)
        (load library nil t)
        (push library my-libs-loaded)))))

(cl-defun load-modules (&optional (modules-dir "modules"))
  (let ((dir (expand-file-name modules-dir user-emacs-directory)))
	(when (f-directory? dir)
	  (load-dir dir my-libs-loaded)
	  (f-directories dir (lambda (d) (load-modules d))))))

(load-modules)
