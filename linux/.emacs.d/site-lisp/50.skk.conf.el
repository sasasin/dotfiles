(require 'skk-autoloads)
; 各種キー設定
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
; SKKを標準のIMEにする
(setq default-input-method "japanese-skk")
; 
(setq skk-preload t)
; 
(add-hook 'isearch-mode-hook
          #'(lambda ()
              (when (and (boundp 'skk-mode)
                         skk-mode
                         skk-isearch-mode-enable)
                (skk-isearch-mode-setup))))
(add-hook 'isearch-mode-end-hook
          #'(lambda ()
              (when (and (featurep 'skk-isearch)
                         skk-isearch-mode-enable)
                (skk-isearch-mode-cleanup))))
; 動的補完
(setq skk-dcomp-activate 't)
; SKKサーバー
(setq skk-server-host "localhost")
(setq skk-server-portnum 1178)
