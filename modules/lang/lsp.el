;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package dap-mode
  :commands (dap-debug)
  :config
  (require 'dap-go)
  (require 'dap-hydra)
  ;; Enabling only some features
  (setq dap-auto-configure-features '(sessions locals controls tooltip))
  (dap-mode 1)
  (dap-ui-mode 1)
  ;; enables mouse hover support
  (dap-tooltip-mode 1)
  ;; use tooltips for mouse hover
  ;; if it is not enabled `dap-mode' will use the minibuffer.
  (tooltip-mode 1)
  ;; displays floating panel with debug buttons
  ;; requies emacs 26+
  (dap-ui-controls-mode 1))

;; go hydra
(use-package hydra
  :after dap-mode
  :config
  (require 'hydra)
  (require 'dap-mode)
  (require 'dap-ui)
  ;;:commands (ace-flyspell-setup)
  :bind
  (:map dap-mode-map
		("M-g" . hydra-go/body))
  :init
  (defhydra hydra-go (:color pink :hint nil :foreign-keys run)
	"
   _n_: Next       _c_: Continue _g_: goroutines      _i_: break log
   _s_: Step in    _o_: Step out _k_: break condition _h_: break hit condition
   _Q_: Disconnect _q_: quit     _l_: locals
   "
	("n" dap-next)
	("c" dap-continue)
	("s" dap-step-in)
	("o" dap-step-out)
	("g" dap-ui-sessions)
	("l" dap-ui-locals)
	("e" dap-eval-thing-at-point)
	("h" dap-breakpoint-hit-condition)
	("k" dap-breakpoint-condition)
	("i" dap-breakpoint-log-message)
	("q" nil "quit" :color blue)
	("Q" dap-disconnect :color red))
  (add-hook 'dap-stopped-hook (lambda (arg) (call-interactively #'hydra-go/body))))
