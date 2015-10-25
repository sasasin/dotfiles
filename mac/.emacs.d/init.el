(require 'cl)

;; package.el setting
(require 'package)
(add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/")  t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/init.d")

(setenv "LANG" "ja_JP.UTF-8")
