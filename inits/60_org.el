;; org-modeの初期化
(require 'org)
(require 'org-install)
;; キーバインドの設定
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)
(define-key global-map "\C-ct" 'org-todo)
;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; org-default-notes-fileのディレクトリ
(setq org-directory "~/Documents/MagicBriefCase/howm/")
(setq org-hide-leading-stars t)

;; org-default-notes-fileのファイル名
(setq org-default-notes-file (concat org-directory "todo.txt"))
(setq org-agenda-files (list org-directory))

;; アジェンダ表示の対象ファイル
(setq org-agenda-files (quote ("~/Documents/magicbriefcase/howm/todo.txt")))

(add-hook 'org-mode-hook 'howm-mode)
(setq org-startup-truncated nil)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
;;(setq howm-view-title-header "*") ;; ← howm のロードより前に書くこと
(setq org-display-custom-times t)
(setq org-time-stamp-custom-formats (quote ("<%Y-%m-%d>" . "<%Y-%m-%d %H-%M>")))


;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAIT(w)" "APPT(a)" "|" "DONE(d)" "SOMEDAY(s)" "CANCELLED(c)")))
;;計時開始時にタグを変更する
(setq org-clock-in-switch-to-state "STARTED")
;; DONEの時刻を記録
(setq org-log-done 'time)



;; ;; org-rememberを使う
;; (org-remember-insinuate)
;; ;; org-rememberのテンプレート
;; (defun my:org-capture-howm-file ()
;;   (expand-file-name
;;    (format-time-string "%Y%m%d-%H%M%S.howm") org-directory))

;; (setq org-remember-templates
;;       '(("Todo" ?t "* TODO %?\n  %i\n  %a" nil "Inbox")
;; 	))

;; org-capture
(require 'org-capture)
(setq org-capture-bookmark nil)
(defun my:org-capture-howm-file ()
  (expand-file-name
   (format-time-string "%Y/%m/%Y-%m-%d-%H%M%S.txt") org-directory))
(global-set-key (kbd "C-c r") 'org-capture)
(setq org-capture-templates
      '(
	("t" "Todo" entry
         (file+headline nil "Inbox")
         "** TODO %?\n"
         :prepend nil
         :unnarrowed nil
         :kill-buffer t)
        )
)

;;mobile org
(setq org-mobile-files org-agenda-files)
(setq org-mobile-inbox-for-pull "~/Documents/MagicBriefCase/howm/flagged.txt")
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-refile-targets '((org-agenda-files :level . 1)))
(setq org-mobile-creating-agendas nil)
(setq org-mobile-agendas 'custom)

;; need org-mode
(defadvice org-mobile-create-sumo-agenda (after org-mobile-create-sumo-agenda-fixup activate)
  "MobileOrgのAgenda Viewsを見やすくする"
  (let ((agendas (expand-file-name "agendas.org" org-mobile-directory)))
    (while (get-file-buffer agendas) (kill-buffer (get-file-buffer agendas)))
    (find-file agendas)
    (goto-char (point-min))
    (while (re-search-forward "\\* .*<after>KEYS=. TITLE: \\(.*\\)</after>\\(\n+\\)" nil t)
      (if (save-match-data (looking-at "\\* "))
	  (replace-match "" t)
	(replace-match "* \\1\\2" t))
      )
    (save-buffer)
    (dolist (entry org-mobile-checksum-files)
      (when (string= "agendas.org" (car entry))
	(setcdr entry (md5 (current-buffer)))
	))
    ))
