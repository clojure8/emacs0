;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package lsp-mode
  :bind
  (:map lsp-mode-map
        ("C-c C-d" . lsp-describe-thing-at-point)
        ("s-<return>" . lsp-execute-code-action)
        ("C-c C-r" . lsp-rename)
        ("C-c C-f" . lsp-format-buffer)
        ("C-c C-c" . lsp-execute-code-action)
        ("C-c C-l" . lsp-lens-mode)
        ("C-c C-i" . lsp-ui-doc-mode)
        ("C-c C-t" . lsp-ui-sideline-mode)
        ("C-c C-s" . lsp-ui-imenu)
        ("C-c C-a" . lsp-ui-peek-find-definitions)
        ("C-c C-b" . lsp-ui-peek-find-references)
        ("C-c C-d" . lsp-ui-peek-find-definitions)
        ("C-c C-e" . lsp-ui-peek-find-implementation)
        ("C-c C-f" . lsp-ui-peek-find-references)
        ("C-c C-g" . lsp-ui-peek-find-workspace-symbol)
        ("C-c C-i" . lsp-ui-peek-find-implementation)
        ("C-c C-j" . lsp-ui-peek-jump-backward)
        ("C-c C-k" . lsp-ui-peek-jump-forward)
        ("C-c C-l" . lsp-ui-peek-find-references)
        ("C-c C-m" . lsp-ui-peek-find-implementation)
        ("C-c C-n" . lsp-ui-peek-jump-backward)
        ("C-c C-o" . lsp-ui-peek-find-definition)
        ("C-c C-p" . lsp-ui-peek-jump-backward)
        )
  :init
  (setq lsp-keymap-prefix "C-l")
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)


(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mod
  )

(use-package consult-lsp :after lsp-mode)
(use-package lsp-treemacs :after lsp-mode)


(provide 'init-lsp)
;;; init-lsp.el ends here
