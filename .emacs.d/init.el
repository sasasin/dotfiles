(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/auto-install/")

;; ~/.emacs.d/elpa 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/elpa")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/init.d")

;; init-loaderを使うので、site-lispは読み込まない
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/")
