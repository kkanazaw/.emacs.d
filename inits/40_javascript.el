;;https://gist.github.com/1471313
;;
;; JavaScriptについて
;;

;; js2-modeを使う
;; しかしインデントが糞なのでjs-modeの物を使う
;;(require 'js2-mode)
;;(autoload 'js2-mode "js2" nil t)
;;(setq-default js2-basic-offset 2)


;;(require 'nvm)
;;(nvm-use (caar (last (nvm--installed-versions))))

(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(add-hook 'js-mode-hook
          #'(lambda ()
	      ;;(flycheck-mode)
              (require 'js)
              (setq js-indent-level 2
                    js-expr-indent-offset 2
                    indent-tabs-mode nil)))

(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))
    ))

(add-hook 'projectile-after-switch-project-hook 'mjs/setup-local-eslint)

(defun mjs/setup-local-eslint ()
  "If ESLint found in node_modules directory - use that for flycheck.
Intended for use in PROJECTILE-AFTER-SWITCH-PROJECT-HOOK."
  (interactive)
  (let ((local-eslint (expand-file-name "~/.ghq/github.com/kkanazaw/mip_client/node_modules/.bin/eslint")))
    (setq flycheck-javascript-eslint-executable
	  (and (file-exists-p local-eslint) local-eslint))))

;; (when (load "js2" t)
;;   (setq js2-bounce-indent-flag nil)
;;   (set-face-foreground 'js2-function-param-face (face-foreground font-lock-variable-name-face))
;;   (defun indent-and-back-to-indentation ()
;;     (interactive)
;;     (indent-for-tab-command)
;;     (let ((point-of-indentation
;;            (save-excursion
;;              (back-to-indentation)
;;              (point))))
;;       (skip-chars-forward "\s " point-of-indentation)))
;;   (define-key js2-mode-map (kbd "C-i") 'indent-and-back-to-indentation)
;;   (define-key js2-mode-map (kbd "C-m") nil)
;;   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

;; ;; インデントの関数の再設定
;; (add-hook 'js2-mode-hook
;;           #'(lambda ()
;;               (require 'js)
;;               (setq js-indent-level 2
;;                     js-expr-indent-offset 2
;;                     indent-tabs-mode nil)
;;               (set (make-local-variable 'indent-line-function) 'js-indent-line)))
