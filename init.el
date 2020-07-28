(setq auto-install-use-wget nil)
; デフォルト言語を日本語に
(set-language-environment "Japanese")
; デフォルト文字コードと、改行コードの設定
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)


;; load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "~/.emacs.d/elisp/skk")
;(add-to-list 'load-path "~/.emacs.d/elisp/howm")
(add-to-list 'load-path "~/.emacs.d/elisp/confluence-el")
(add-to-list 'load-path "~/.emacs.d/elisp/org-confluence")
;;(add-to-list 'load-path "~/.emacs.d/elisp/magit") ;;24.3以下だとmagit入らないので

(require 'cl)
;;package.elの設定
(when (require 'package nil t)
  ;;パッケージリポジトリにmelpa,Marmalade,開発者運営のELPAを追加
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("ELPA" . "https://elpa.gnu.org/packages/"))
  ;;インストールするディレクトリを指定
  (setq package-user-dir(concat user-emacs-directory "elpa"))
  ;;インストールしたパッケージにロードパスを通して読み込む
  (package-initialize)

  (defvar installing-package-list
    '(
      init-loader
      evil
      evil-leader
      evil-nerd-commenter
      evil-numbers
      color-theme
      color-theme-monokai
      color-moccur
      php-mode 
     ;;inf-php
      python-mode
      markdown-mode
      scss-mode
      haskell-mode
      rspec-mode
      haml-mode
      yaml-mode
      auto-complete
      flymake
      flymake-ruby
      flymake-php
      flymake-shell
      flymake-cursor
      google-c-style
      open-junk-file
      smart-compile
      color-theme-solarized
      ruby-block
      ruby-electric
      inf-ruby
      bundler
      powerline
      flex-autopair
      auto-install
      magit
      web-mode
      all-ext
      shell-history
      org
      mmm-mode
      yasnippet
      ac-python
      bash-completion
      dsvn
      multi-term
      pcre2el 
     ;;perl-completion
      php-completion
      popup
      recentf-ext
      shell-pop
      zlc
      js2-mode
      howm
      use-package
      ))

  (let ((not-installed (loop for x in installing-package-list
			     when (not (package-installed-p x))
			     collect x)))
    (when not-installed
      (package-refresh-contents)
      (dolist (pkg not-installed)
        (package-install pkg))))

)

;;(server-start)
;; init-loader.el
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits") ; 設定ファイルがあるディレクトリを指定
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "color-239" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(confluence-code-face ((t (:foreground "color-46" :weight bold))))
 '(flymake-error ((t (:foreground "white" :background "red"))))
 '(flymake-warning ((t (:foreground "white" :background "yellow"))))
 '(howm-mode-title-face ((t (:foreground "blue")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anything-c-moccur-anything-idle-delay 0.1)
 '(anything-c-moccur-enable-auto-look-flag t)
 '(anything-c-moccur-enable-initial-pattern t)
 '(anything-c-moccur-higligt-info-line-flag t)
 '(anything-kill-ring-threshold 5 t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(flycheck-disabled-checkers (quote (javascript-jshint javascript-jscs)))
 '(git-commit-setup-hook
   (quote
    (git-commit-save-message git-commit-setup-changelog-support git-commit-propertize-diff with-editor-usage-message)))
 '(package-selected-packages
   (quote
    (csv-mode helm-core helm elpy jedi typescript-mode slim-mode ctags add-node-modules-path flycheck vue-mode projectile howm js2-mode zlc shell-pop recentf-ext php-completion yasnippet yaml-mode web-mode smart-compile shell-history scss-mode ruby-electric ruby-block rspec-mode python-mode powerline php-mode pcre2el open-junk-file multi-term mmm-mode markdown-mode magit init-loader haskell-mode haml-mode google-c-style flymake-shell flymake-ruby flymake-php flymake-cursor flex-autopair evil-numbers evil-nerd-commenter evil-leader dsvn color-theme-solarized color-theme-monokai color-moccur bundler bash-completion auto-install all-ext ac-python)))
 '(php-executable "/usr/bin/php")
 '(php-mode-coding-style (quote psr2)))

