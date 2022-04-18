;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package eglot
  :commands (eglot)
  :bind
  (:map eglot-mode-map
        ("s-<return>" . eglot-code-actions)
        )
  :config
  (setq eglot-connect-timeout 10)
  (setq eglot-sync-connect t)
  (setq eglot-autoshutdown t)
  )

(use-package consult-eglot
  :after eglot
  :commands (consult-eglot)
  )


(provide 'init-eglot)
;;; init-eglot.el ends here
