(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く
    auto-compile
    auto-complete
    auto-install
    init-loader
    open-junk-file
    helm
    multi-term
    yaml-mode
    ))

(let ((not-installed (loop for x in installing-package-list
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))
