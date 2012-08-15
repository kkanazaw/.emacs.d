;;https://gist.github.com/1471313
;;
;; JavaScriptについて
;;

;; js2-modeを使う
;; しかしインデントが糞なのでjs-modeの物を使う
(autoload 'js2-mode "js2" nil t)
(setq-default js2-basic-offset 4)

(when (load "js2" t)
  (setq js2-bounce-indent-flag nil)
  (set-face-foreground 'js2-function-param-face (face-foreground font-lock-variable-name-face))
  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))
  (define-key js2-mode-map (kbd "C-i") 'indent-and-back-to-indentation)
  (define-key js2-mode-map (kbd "C-m") nil)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

;; インデントの関数の再設定
(add-hook 'js2-mode-hook
          #'(lambda ()
              (require 'js)
              (setq js-indent-level 4
                    js-expr-indent-offset 4
                    indent-tabs-mode nil)
              (set (make-local-variable 'indent-line-function) 'js-indent-line)))
