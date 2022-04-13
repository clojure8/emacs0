;; -*- coding: utf-8; lexical-binding: t; -*-


(use-package mu4e
  :commands (mu4e)
  :load-path "/usr/local/share/emacs/site-lisp/mu/mu4e/"
  :config
  (require 'mu4e)

  ;; 配置 mu4e 作为 MUA 以及基本的邮件信息配置
  (setq mail-user-agent 'mu4e-user-agent)
  (setq user-full-name "clojure8")
  (setq user-mail-address "clojure8@gmail.com")

  ;; 配置使用 offlieimap 收取邮件
  (setq
   mu4e-get-mail-command "offlineimap"   ;; 使用 offlineimap 获取邮件
   mu4e-update-interval 300)             ;; 每五分钟检查邮件并更新索引 (配置单位：秒)

  ;; 配置默认 smtp 服务以使用 smtpmail mode 发送 Email
  ;; SMTP 服务需要认证，我采用 ~/.authinfo.gpg 的方式提供认证信息。
  ;; 有关 SMTP 认证, 参阅 https://www.emacswiki.org/emacs/SmtpAuth
  (setq send-mail-function 'smtpmail-send-it
		message-send-mail-function 'smtpmail-send-it
		smtpmail-smtp-server  "smtp.office365.com"
		smtpmail-smtp-service 587
		;; smtpmail-auth-credentials (())
		smtpmail-auth-credentials "~/.authinfo.gpg"
		smtpmail-stream-type  'starttls))
