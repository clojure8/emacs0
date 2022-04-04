;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://genehack.blog/2020/08/web-mode-eglot-vetur-vuejs-=-happy/
;;
;; web-mode : https://web-mode.org/
;; typescript extension: https://github.com/ananthakumaran/tide
;;

(use-package web-mode :defer t)

(use-package js2-mode :after web-mode)

(use-package simple-httpd
  :after web-mode
  :config
  (setq httpd-root "~/temp/var/www")
  (httpd-start))

;; 在线编辑增强
(use-package skewer-mode
  :after web-mode
  :config
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'css-mode-hook 'skewer-css-mode)
  (add-hook 'html-mode-hook 'skewer-html-mode))

;;TODO add some config
(use-package emmet-mode
  :defer t)

;;TODO https://github.com/osv/company-web/tree/863fb84b81ed283474e50330cd8d27b1ca0d74f1
