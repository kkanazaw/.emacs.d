;; org-mode
(require 'org)
(add-hook 'org-mode-hook 'howm-mode)
(setq org-startup-truncated nil)
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
;;(setq howm-view-title-header "*") ;; ← howm のロードより前に書くこと

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

