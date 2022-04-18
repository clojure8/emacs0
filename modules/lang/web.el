;; -*- coding: utf-8; lexical-binding: t; -*-

;; https://genehack.blog/2020/08/web-mode-eglot-vetur-vuejs-=-happy/
;;
;; web-mode : https://web-mode.org/
;; typescript extension: https://github.com/ananthakumaran/tide
;;

(use-package web-mode :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))

(use-package js2-mode :after web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.ts\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.tsx\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.pug\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.ejs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.hbs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.jade\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\.pug\\'" . web-mode)))

(use-package rjsx-mode :after web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil)
  )

(use-package simple-httpd
  :after web-mode
  )

;; 在线编辑增强
(use-package skewer-mode
  :hook ((js2-mode . skewer-mode)
         (css-mode . skewer-css-mode)
         (html-mode . skewer-html-mode))
  :config
  (setq httpd-port 9999)
  (setq httpd-root "~/temp/var/www")
  (httpd-start)
  )

;;TODO add some config
(use-package emmet-mode
  :hook ((html-mode . emmet-mode)
         (css-mode . emmet-mode))
  :config
  (setq emmet-move-cursor-between-quotes t)
  )

;;TODO https://github.com/osv/company-web/tree/863fb84b81ed283474e50330cd8d27b1ca0d74f1
(use-package company-web
  :after web-mode
  :config
  (add-to-list 'company-backends 'company-web-html)
  (add-to-list 'company-backends 'company-web-jade)
  (add-to-list 'company-backends 'company-web-slim)
  )

(provide 'init-web)
