;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package anaconda-mode
  :hook (python-mode . (anaconda-mode anaconda-eldoc-mode)))

(use-package company-anaconda
  :commands (company-anaconda))
