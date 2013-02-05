(setq auto-install-use-wget nil)
; デフォルト言語を日本語に
(set-language-environment "Japanese")
; デフォルト文字コードと、改行コードの設定
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; load-path
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/skk")
(add-to-list 'load-path "~/.emacs.d/elisp/howm")
(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/elisp/mmm-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/magit")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-w3m/share/emacs/site-lisp/w3m/")
(add-to-list 'load-path "~/.emacs.d/elisp/org")
(add-to-list 'load-path "~/.emacs.d/elisp/confluence-el")
(add-to-list 'load-path "~/.emacs.d/elisp/org-confluence")
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
  (package-initialize)
)

(server-start)
;; init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "color-239" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(confluence-code-face ((t (:foreground "color-46" :weight bold)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark))))

