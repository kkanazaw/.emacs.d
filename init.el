; デフォルト言語を日本語に
(set-language-environment "Japanese")
; デフォルト文字コードと、改行コードの設定
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/elisp/skk")
(add-to-list 'load-path "~/.emacs.d/elisp/howm")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")
(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/elisp/mmm-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/magit")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-w3m/share/emacs/site-lisp/w3m/")
;(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;(add-to-list 'load-path "~/.emacs.d/rhtml")
;(add-to-list 'load-path "~/.emacs.d/scala")
;(add-to-list 'load-path "~/.emacs.d/slime")
;(add-to-list 'load-path "~/.emacs.d/w3m")
;(add-to-list 'load-path "~/.emacs.d/erlang-mode")
;(add-to-list 'load-path "~/.emacs.d/auto-complete")

;;package.elの設定
(when (require 'package nil t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;パッケージリポジトリにMarmaladeと開発者運営のELPAを追加
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
;;インストールするディレクトリを指定
(setq package-user-dir(concat user-emacs-directory "elpa"))
;;インストールしたパッケージにロードパスを通して読み込む
(package-initialize))

;; init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
