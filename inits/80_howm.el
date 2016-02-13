;; howm
;;https://github.com/kyanny/emacs-config/blob/master/dot.emacs.d/inits/83_howm.el
(setq howm-compatible-to-ver1dot3 t)
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(global-set-key "\C-c,a" 'howm-list-all)
(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
(setq howm-directory "~/howm/")
(setq howm-view-use-grep t)
(setq howm-menu-file "~/howm/0000-00-00-000000.txt")
;;(setq howm-view-grep-command "egrep")
;;(setq howm-view-fgrep-command "fgrep")
;;(setq howm-view-grep-option "-Hnr")
;;(setq howm-process-coding-system '(utf-8-dos . utf-8-unix))

;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.txt")

(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))

;; t splits window in half
(setq howm-view-summary-window-size 8)

(setq howm-menu-recent-num 5)

(require 'anything-howm)
(require 'cl)

;; 「最近のメモ」をいくつ表示するか
(setq ah:recent-menu-number-limit 600)

(setq ah:menu-file-pattern "0000-00-00-000000.txt$")

;; howm のデータディレクトリへのパス
(setq ah:data-directory howm-directory)

(global-set-key (kbd "C-c 2") 'ah:menu-command)
(global-set-key (kbd "C-c 3") 'ah:cached-howm-menu)

