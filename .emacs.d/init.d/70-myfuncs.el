; private functions

; insert current time.
(defun whatnow ()
  (interactive)
  (insert (format-time-string "%Y/%m/%d %H:%M:%S @ "))
)
; reload ~/.emacs
(defun reload-emacs ()
  (interactive)
  (load-library "~/.emacs.d/init")
)

; insert "<verbatim>\n\n</verbatim>"
(defun in-verbatim ()
  (interactive)
  (insert "<verbatim>\n\n</verbatim>")
)

;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
;; リージョン内の行数と文字数をモードラインに表示する（範囲指定している時だけ）
;; 1文字1charで計算。
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
	      (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ;; これだとエコーエリアがチラつく
    ;;(count-lines-region (region-beginning) (region-end)) 
    ""))

(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))


