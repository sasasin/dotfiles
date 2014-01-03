;(server-start)

(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))

;; 編集完了時にEmacsをアイコン化する
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
;; 

(global-set-key (kbd "C-x C-c") 'server-edit)

;; M-x exit でEmacsを終了できるようにする
(defalias 'exit 'save-buffers-kill-emacs)
