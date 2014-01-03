;; 日本語を標準にする
(set-language-environment "Japanese")

;; 文字コードはUTF-8を、改行コードはLFを、標準にする
(prefer-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)

;;(if (not window-system) (set-terminal-coding-system 'utf-8-unix))
;;(universal-coding-system-argument 'utf-8-unix)

;; git commit のメッセージ編集時の文字コードをUTF8にする
;; http://d.hatena.ne.jp/gan2/20091110/1257859005
(add-hook 'find-file-hooks
          (function (lambda ()
                      (if (string-match "COMMIT_EDITMSG" buffer-file-name)
                          (set-buffer-file-coding-system 'utf-8)))))

