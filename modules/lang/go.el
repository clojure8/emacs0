;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  ;; :config
  ;; (use-package s :defer t)
  ;; (add-hook 'after-save-hook
  ;;           (lambda () (when (s-ends-with? ".go" (buffer-name))
  ;;                    (progn (lsp-format-buffer)
  ;;                           (save-buffer)))))
  )
