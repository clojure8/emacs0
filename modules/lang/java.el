;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package lsp-java
  :defer t
  :config
  ;; (setq lsp-java-configuration-runtimes
  ;; 		'[(:name "jdk8"
  ;; 				 :path "/usr/local/Cellar/openjdk@8/1.8.0+322/libexec/openjdk.jdk/Contents/Home"
  ;; 				 :default t)
  ;; 		  (:name "jdk11"
  ;; 				 :path "/usr/local/Cellar/openjdk@11/11.0.14.1/libexec/openjdk.jdk/Contents/Home"
  ;; 				 )])
  ;;
  (use-package lsp-ui :after lsp-mode)
  (use-package consult-lsp :after lsp-mode)
  (use-package lsp-treemacs :after lsp-mode)
  )

(use-package dap-mode
  :after lsp-mode
  :config (dap-auto-configure-mode))

(use-package dap-java
  :after lsp-mode :ensure nil)
