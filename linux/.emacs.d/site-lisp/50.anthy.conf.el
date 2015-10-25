; anthy.el をロードできるようにする (必要に応じて)。
(push "/usr/share/emacs/site-lisp/anthy/" load-path)
; anthy.el をロードする。
(load-library "anthy")
; japanese-anthy をデフォルトの input-method にする。
(setq default-input-method "japanese-anthy")
