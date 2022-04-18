;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

;; 自动缩进
(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode)
  )

;;代码格式化
(use-package apheleia :defer t)

(use-package quickrun
  :commands (quickrun))

;; (add-hook 'prog-mode-hook #'electric-pair-mode)

(use-package format-all
  :hook (prog-mode . format-all-ensure-formatter)
  :preface
  (defun ian/format-code ()
    "Auto-format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-buffer)))
  :config
  (global-set-key (kbd "M-F") #'ian/format-code))
;; (add-hook 'prog-mode-hook #'format-all-ensure-formatter))

(use-package editorconfig :defer t)

(provide 'init-prog)
;;; init-prog.el ends here
