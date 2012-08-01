;; org-mode
(require 'org)
(add-hook 'org-mode-hook 'howm-mode)
(setq org-startup-truncated nil)
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
;;(setq howm-view-title-header "*") ;; ← howm のロードより前に書くこと

;; howm
;;https://github.com/kyanny/emacs-config/blob/master/dot.emacs.d/inits/83_howm.el
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(global-set-key "\C-c,a" 'howm-list-all)
(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
(setq howm-directory "~/Documents/magicbriefcase/howm/")
(setq howm-view-use-grep t)
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

;; (require 'anything-howm)

;; (defun anything-buffers ()
;;   (interactive)
;;   (anything-other-buffer
;;    '(
;;      ;; anything-c-source-buffers  ;;これをやめて
;;      anything-c-source-buffers+-howm-title ;;これを追加
;;      anything-c-source-recentf ;;など
;;      ;; ...
;;      )
;;    "*Buffer+File*"))

;; (global-set-key (kbd "C-l") 'anything-buffers)
;; (global-set-key (kbd "C-2") 'anything-howm-menu-command)
;; (global-set-key (kbd "C-3") 'anything-cached-howm-menu)

;; ;; 「最近のメモ」をいくつ表示するか
;; (setq anything-howm-recent-menu-number-limit 600)

;; ;; howm のデータディレクトリへのパス
;; (setq anything-howm-data-directory "~/Dropbox/howm/")