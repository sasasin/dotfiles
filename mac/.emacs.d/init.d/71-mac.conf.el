;; MacでGUIの時、optionをmeta
(if window-system (progn
    (when (equal system-type 'darwin)
      (setq mac-option-modifier 'meta))
))

;; ミニバッファに入力時、自動的に英語モード
(when (functionp 'mac-auto-ascii-mode)  
  (mac-auto-ascii-mode 1))

;; http://qiita.com/aKenjiKato/items/4ac7d9b100bdce0b8920
;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [165] [92]) ;; 165が¥（円マーク） , 92が\（バックスラッシュ）を表す


