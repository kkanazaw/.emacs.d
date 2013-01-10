;auto-install設定
;http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)



;; ---------------------------------------------------
;; 基本設定
;; ---------------------------------------------------
; 初期ディレクトリを設定
(setq default-directory "~/")

;; prevent from creating backup
(setq make-backup-files nil)

;; skip startup message
(setq inhibit-startup-message t)

;; emphasize blankets
(show-paren-mode t)

; ヴィジブルベルを抑制
(setq visible-bell nil)

; ビープ音を抑制
(setq ring-bell-function '(lambda ()))

; yes/no を y/n へ簡略化
(fset 'yes-or-no-p 'y-or-n-p)

; 行番号の表示
(line-number-mode t)

; 列番号の表示
(column-number-mode t)

; リージョンを反転
(setq transient-mark-mode t)

(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;recentf
(require 'recentf-ext)

;;dired
(require 'dired-x)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(display-time)

(global-set-key (kbd "C-x p") '(lambda () (interactive) (other-window -1)))

(require 'pcre2el)

