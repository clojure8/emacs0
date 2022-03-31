;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:


;; 自动缩进
(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode)
  ;; :config
  ;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

;;代码格式化
(use-package prettier :defer t)
(use-package apheleia :defer t)
