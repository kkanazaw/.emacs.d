;;http://d.hatena.ne.jp/gologo13/20100926/1285495181
(require 'cc-mode)

;; .hpp と .h を C++ の拡張子とする
(setq auto-mode-alist
      (append
       '(("\\.hpp$" . c++-mode)
         ("\\.h$"   . c++-mode)
         ) auto-mode-alist))

;; google-c-style
(require 'google-c-style)
(add-hook 'c-mode-hook 'google-set-c-style)
(add-hook 'c-mode-hook 'google-make-newline-indent)
(add-hook 'c++-mode-hook 'google-set-c-style)
(add-hook 'c++-mode-hook 'google-make-newline-indent)


;; 補完対象のユーザー定義マッチング関数
(defun ac-prefix-c-dot-ref-scope ()
  "C-like languages dot(.) and reference(->) and scope(::) prefix."
  (if (re-search-backward "\\(?:\\.\\|->\\|::\\)\\(\\(?:[a-zA-Z0-9][_a-zA-Z0-9]*\\)?\\)\\=" nil t)
      (match-beginning 1)))

;http://d.nym.jp/archives/2006/11/27015229.html
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-map "\M-t" 'ff-find-other-file)
            (define-key c++-mode-map "\M-t" 'ff-find-other-file)
	    (require 'cedet)
	    (semantic-mode 1)
	    (semantic-add-system-include "/usr/include" 'c++-mode)
	    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.5.3/include" 'c++-mode)
	    (setq semanticdb-default-save-directory "~/.emacs.d/semanticdb")
	    ;; http://www.gnu.org/software/emacs/manual/html_mono/semantic.html#Search-Throttle
	    (setq-mode-local c++-mode semanticdb-find-default-throttle
			     '(project unloaded system recursive))
	    (setq eieio-skip-typecheck t)
	    ;; 関連リストの標準関数をユーザー定義のマッチング関数で置換
	    (setcdr (assq 'c-dot-ref ac-prefix-definitions) 'ac-prefix-c-dot-ref-scope)

	    )
	  )

;; http://memo.saitodev.com/home/emacs/#c-c
;; (require 'flymake)
;; ;; 文法チェックの頻度の設定
;; (setq flymake-no-changes-timeout 1)
;; ;; 改行時に文法チェックを行うかどうかの設定
;; (setq flymake-start-syntax-check-on-newline nil)

;; (setq gcc-warning-options
;;       '("-Wall" "-Wextra" "-Wformat=2" "-Wstrict-aliasing=2" "-Wcast-qual"
;;       "-Wcast-align" "-Wwrite-strings" "-Wfloat-equal"
;;       "-Wpointer-arith" "-Wswitch-enum"
;;       ))

;; (setq gxx-warning-options
;;       `(,@gcc-warning-options "-Woverloaded-virtual" "-Weffc++")
;;       )

;; (setq gcc-cpu-options '("-msse" "-msse2" "-mmmx"))

;; (defun flymake-c-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name)))
;;        )
;;     (list "gcc" `(,@gcc-warning-options ,@gcc-cpu-options "-fsyntax-only" ,local-file))
;;     ))
;; (push '(".+\\.c$" flymake-c-init) flymake-allowed-file-name-masks)
;; (add-hook 'c-mode-hook '(lambda () (flymake-mode t)) )

;; (defun flymake-c++-init ()
;;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;          (local-file  (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;     (list "g++" `(,@gxx-warning-options ,@gcc-cpu-options "-fsyntax-only" ,local-file))
;;     ))
;; (push '(".+\\.h$" flymake-c++-init) flymake-allowed-file-name-masks)
;; (push '(".+\\.cc$" flymake-c++-init) flymake-allowed-file-name-masks)
;; (add-hook 'c++-mode-hook '(lambda () (flymake-mode t)) )

