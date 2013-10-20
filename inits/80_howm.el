;; howm
;;https://github.com/kyanny/emacs-config/blob/master/dot.emacs.d/inits/83_howm.el
(setq howm-compatible-to-ver1dot3 t)
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(global-set-key "\C-c,a" 'howm-list-all)
(autoload 'howm-menu "howm" "Hitori Otegaru Wiki Modoki" t)
(setq howm-directory "~/Documents/MagicBriefCase/howm/")
(setq howm-view-use-grep t)
(setq howm-menu-file "~/Documents/MagicBriefCase/howm/0000-00-00-000000.txt")
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
(setq anything-howm-recent-menu-number-limit 600)

;;(defvar key-separator ":")

(setq my-anything-howm-menu-file-pattern "0000-00-00-000000.txt$")

;; howm のデータディレクトリへのパス
(setq anything-howm-data-directory howm-directory)

;; (setq recent-hash (make-hash-table :test 'equal))

;; (defun my-anything-howm-persistent-action (candidate)
;;   (let ((buffer (get-buffer-create anything-howm-persistent-action-buffer)))
;;       (with-current-buffer buffer
;;         (erase-buffer)
;;         (insert-file-contents (gethash candidate recent-hash))
;;         (goto-char (point-min)))
;;       (pop-to-buffer buffer)
;;       (howm-mode t)))

;; (defun my-anything-howm-title-real-to-display (candidate)
;;   (if (string-match "^[0-9]*:\\(.*\\)" candidate) (match-string 1 candidate))
;; )

;; (defvar my-anything-c-howm-recent
;;   '((name . "最近のメモ")
;;     (init . (lambda ()
;;               (with-current-buffer (anything-candidate-buffer 'global) 
;; 		(setq recent-hash (make-hash-table :test 'equal))
;; 		(setq recent-list (howm-recent-menu anything-howm-recent-menu-number-limit))
;; 		(let ((candidate-num -1))
;; 		  (mapc (lambda(file)
;; 			  (cond ((not (string-match-p my-anything-howm-menu-file-pattern (first file)))
;; 				 (incf candidate-num)
;; 				 (puthash (concat (number-to-string candidate-num) key-separator (second file)) (first file) recent-hash)
;; 				 ))) recent-list)
;; 		  )
;; 		  (insert (mapconcat 'identity (loop for k being the hash-keys in recent-hash collect k) "\n"))
;; 		)
;; 	      )
;; 	  )
;;     (candidates-in-buffer)
;;     (candidate-number-limit . 9999)
;;     (real-to-display . my-anything-howm-title-real-to-display)
;;     (action .
;; 	    (
;;        ("Open howm file(s)" .
;;  	  (lambda(candidate)(find-file (gethash candidate recent-hash))))
;;        ("Open howm file in other window" .
;;           (lambda (candidate)
;;             (find-file-other-window
;;              (find-file (gethash candidate recent-hash)))))
;;        ("Open howm file in other frame" .
;;           (lambda (candidate)
;;             (find-file-other-frame
;;              (find-file (gethash candidate recent-hash)))))
;;        ("Create new memo" .
;;           (lambda (template)
;;             (anything-howm-create-new-memo "")))
;;        ("Create new memo on region" .
;;           (lambda (template)
;;             (anything-howm-create-new-memo (anything-howm-set-selected-text))))
;;        ("Delete file(s)" . anything-howm-delete-marked-files)))
;;     (persistent-action . my-anything-howm-persistent-action)
;;     (cleanup .
;;       (lambda ()
;;         (anything-aif (get-buffer anything-howm-persistent-action-buffer)
;;           (kill-buffer it))))
;;     (migemo)
;;     ))


;; ;;移動した時に内容をプレビューする
;; (defadvice anything-move-selection-common (after anything-howm-preview) 
;;   (when (string= (cdr (assq 'name (anything-get-current-source)
;; 			    )) "最近のメモ" )
;;     (anything-execute-persistent-action)
;;     )
;;   )

;; (ad-deactivate-regexp "anything-howm-preview")

;; (defun my-anything-howm-display-buffer (buf)
;;   "左右分割で表示する"
;;   (delete-other-windows)
;;   (split-window (selected-window) 25 t)
;;   (other-window 1)
;;   (pop-to-buffer buf))


;; (defun my-anything-cached-howm-menu ()
;;   (interactive)
;;   (ad-activate-regexp "anything-howm-preview")
;;   (let ((anything-display-function 'my-anything-howm-display-buffer))    
;;     (if (get-buffer anything-howm-menu-buffer)
;;         (anything-resume anything-howm-menu-buffer)
;;       (my-anything-howm-menu-command))
;;     )
;;   (ad-deactivate-regexp "anything-howm-preview")
;;   )

;; (defun my-anything-howm-menu-command ()
;;   (interactive)
;;   (ad-activate-regexp "anything-howm-preview")
;;   (let ((anything-display-function 'my-anything-howm-display-buffer))
;;     (anything-other-buffer
;;      '(anything-c-source-howm-menu
;;        my-anything-c-howm-recent)
;;      anything-howm-menu-buffer)
;;     )
;;   (ad-deactivate-regexp "anything-howm-preview")
;;   )

;; (global-set-key (kbd "C-c 2") 'my-anything-howm-menu-command)
;; (global-set-key (kbd "C-c 3") 'my-anything-cached-howm-menu)
(global-set-key (kbd "C-c 2") 'ah:menu-command)
(global-set-key (kbd "C-c 3") 'ah:cached-howm-menu)

