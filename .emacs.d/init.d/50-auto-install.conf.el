;; auto-install.el設定
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup) ; install-elisp との互換性を確保
;;(setq ediff-window-setup-function 'ediff-setup-windows-plain)
