;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package winum :defer t)

(use-package eyebrowse
  :hook (after-init . eyebrowse-mode))

(use-package popper
  :defer t
  :custom
  ((popper-window-height 16))
  :bind (("M-`"   . popper-toggle-latest)
         ("C-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
		  "\\*Launch.*\\*$"
		  "*vterm*"
		  "*eshell*"
		  "*Dtache.*"
		  "*quickrun*"
		  "*devdocs*"
		  "*Go-Translate*"
		  "*PLANTUML Preview*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))


(use-package ace-window :defer t)

(use-package zoom
  :defer t
  ;; :hook (after-init . zoom-mode)
  :config
  (setq zoom-size '(0.718 . 0.718)))
