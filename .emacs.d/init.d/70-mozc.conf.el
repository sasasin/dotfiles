
;; mozc
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

; https://plus.google.com/102550604876259086885/posts/74LmaNoWs26
; �Ѵ����˸���ꥹ�Ȥ�����ʸ����Τ������˽Ф�褦�ˤʤ롣
;(setq mozc-candidate-style 'overlay)
;; �Ѵ������ߥ˥Хåե���ɽ��
(setq mozc-candidate-style 'echo-area)
