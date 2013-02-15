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

;; https://bitbucket.org/sooh/dot.emacs.d/src/4eae87efd029/start.d/init_screen.el
;; mode line
(progn
  (setq display-time-24hr-format 1)     ; 24時間表示
  ;; (setq display-time-format "%m/%d(%a) %H:%M") ; 月日時分の表示順に %Y- ← 年表示
  ;; (setq display-time-day-and-date t)              ; 日時を表示
  (setq display-time-interval 30)                 ; インターバル
  (display-time))
;; menu-barを消す
(menu-bar-mode -1)



(global-set-key (kbd "C-x p") '(lambda () (interactive) (other-window -1)))

(require 'pcre2el)

