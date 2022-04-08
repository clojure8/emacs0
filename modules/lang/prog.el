;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:


;; 自动缩进
(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode)
  ;; :config
  ;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

;;代码格式化
(use-package apheleia :defer t)

(use-package quickrun
  :commands (quickrun))

(add-hook 'prog-mode-hook #'electric-pair-mode)
