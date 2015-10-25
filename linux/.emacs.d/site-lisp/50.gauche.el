(modify-coding-system-alist 'process "gosh" '(utf-8 . utf-8))

(setq scheme-program-name "gosh -i")
;;for XEmacs
;;(setq scheme-program-name "gosh")
;;(setq scheme-program-args "-i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()  
  "Run scheme on other window"  
  (interactive)  
  (switch-to-buffer-other-window  
   (get-buffer-create "*scheme*"))  
  (run-scheme scheme-program-name))  

(define-key global-map  
  "\C-cs" 'scheme-other-window)
