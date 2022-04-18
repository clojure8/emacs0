;; -*- coding: utf-8; lexical-binding: t; -*-
;;; code:

(use-package lsp-java
  :hook (java-mode . lsp)
  :config
  ;; (setq lsp-java-server-install-dir (expand-file-name "~/.emacs.d/lsp-java-server"))
  ;; (setq lsp-java-workspace-dir (expand-file-name "~/.emacs.d/lsp-java-workspace"))
  ;; (setq lsp-java-workspace-cache-dir (expand-file-name "~/.emacs.d/lsp-java-workspace-cache"))
  ;; (setq lsp-java-vmargs (list "-noverify" "-Xmx1G" "-XX:+UseG1GC"))
  ;; (setq lsp-java-import-gradle-enabled t)
  ;; (setq lsp-java-import-gradle-use-workspace-root t)
  ;; (setq lsp-java-import-gradle-use-gradlew t)
  ;; (setq lsp-java-import-gradle-gradlew-path (expand-file-name "~/.emacs.d/gradlew"))
  ;; (setq lsp-java-import-gradle-gradle-version "4.10.3")
  ;; (setq lsp-java-import-gradle-gradle-wrapper-enabled t)
  ;; (setq lsp-java-import-gradle-gradle-wrapper-use-gradle-distribution nil)
  ;; (setq lsp-java-import-gradle-gradle-wrapper-distribution-use-wrapper t)
  ;; (setq lsp-java-import-gradle-gradle-wrapper-distribution-path (expand-file-name "~/.emacs.d/gradle/wrapper/gradle-wrapper.jar"))
  ;; (setq lsp-java-import-gradle-gradle-wrapper-distribution-version "5.4.1")
  ;; (setq lsp-java-import-gradle-gradle-wrapper-distribution-download-url "https://services.gradle.org/distributions/gradle-5.4.1-bin.zip")

  ;; ;; (setq lsp-java-configuration-runtimes
  ;;        '[(:name "jdk8"
  ;;                 :path "/usr/local/Cellar/openjdk@8/1.8.0+322/libexec/openjdk.jdk/Contents/Home"
  ;;                 :default t)
  ;;          (:name "jdk11"
  ;;                 :path "/usr/local/Cellar/openjdk@11/11.0.14.1/libexec/openjdk.jdk/Contents/Home"
  ;;                 )])
  ;;
  )


(provide 'init-java)
;;; packages.el ends here
