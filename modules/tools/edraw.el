;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package edraw
  :load-path "~/elisp/el-easydraw"
  :commands (edraw-mode
			 edraw-color-picker-read-color
			 edraw-color-picker-replace-color-at-point
			 edraw-color-picker-insert-color)
  :config
  (require 'edraw-org)
  (edraw-org-setup-default))
