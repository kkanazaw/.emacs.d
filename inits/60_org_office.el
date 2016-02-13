(setq org-directory "~/howm/")
;; org-default-notes-fileのファイル名
(setq org-default-notes-file (concat org-directory "todo.txt"))
(setq org-agenda-files (list org-directory))

;; アジェンダ表示の対象ファイル
(setq org-agenda-files (quote ("~/howm/todo.txt")))
;; https://github.com/hgschmie/org-confluence
(require 'confluence)
(require 'org-confluence)

(add-to-list 'auto-mode-alist '("createpage\\.action$" . confluence-edit-mode))
