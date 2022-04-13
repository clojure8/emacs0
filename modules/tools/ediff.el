;; -*- coding: utf-8; lexical-binding: t; clojure8-load?: t ;-*-

(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default)
            ',variable ,value))

;;不要在单独的框架中使用控制面板,这个设置很奇怪
(csetq ediff-window-setup-function 'ediff-setup-windows-plain)

;;将窗户水平分开，而不是垂直分开。这样，更容易跟踪变更
(csetq ediff-split-window-function 'split-window-horizontally)

;;忽略空格
(csetq ediff-diff-options "-w")

;;更改Ediff快捷键
(defun ora-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))

(add-hook 'ediff-mode-hook 'ora-ediff-hook)

(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
