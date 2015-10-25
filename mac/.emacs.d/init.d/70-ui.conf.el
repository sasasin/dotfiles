(defun my-ui-conf ()
  (interactive)
  ;; アンチエイリアスなフォント設定
  (cond (window-system
	 (set-default-font "Ricty Diminished-18")
	 (set-fontset-font (frame-parameter nil 'font)
			   'japanese-jisx0208
			   '("Ricty Diminished-18" . "Unicode-bmp"))
	 ))
  ;; フレームサイズ
  (if window-system
      ;; フルスクリーン
      (set-frame-parameter nil 'fullscreen 'fullboth))

  ;; コピペ設定
  (if window-system
      (setq x-select-enable-clipboard t))

)
(my-ui-conf)

;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)

;; 編集時のバックアップファイル作成を抑止
(setq make-backup-files nil)
;; ファイルの先頭に #! が含まれているとき、自動的に chmod +x
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; 自動で色付けする
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
;; 対応するカッコをハイライト
(show-paren-mode 1)
;; カーソル行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "lavender blush"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; ツールバーを非表示にする
(tool-bar-mode -1)
;; 行桁番号表示
(line-number-mode 1)
(column-number-mode 1)
;; 時刻＆システム負荷表示
(display-time)
(setq display-time-24hr-format t)
;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)
;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; スクロールを一行ずつにする
(setq scroll-step 1)
;; スクロールバーを右側に表示する
(set-scroll-bar-mode 'right)
;; 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; マウスで選択するとコピー。nilはコピーしない。
(setq mouse-drag-copy-region nil)

;; find-fileのデフォを~/にする
(setq default-directory "~/") 
(setq command-line-default-directory "~/")
