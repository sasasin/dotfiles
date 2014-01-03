
;; mozc
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

; https://plus.google.com/102550604876259086885/posts/74LmaNoWs26
; 変換時に候補リストが入力文字列のすぐ下に出るようになる。
;(setq mozc-candidate-style 'overlay)
;; 変換候補をミニバッファへ表示
(setq mozc-candidate-style 'echo-area)
