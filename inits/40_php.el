(require 'php-mode)
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.inc\\'" . php-mode) auto-mode-alist))
;;(setq php-mode-force-pear t)
(global-set-key (kbd "C-M-_") 'indent-region)


;; php-mode-hook
(add-hook 'php-mode-hook
          (lambda ()
	    (c-set-style "psr2")
	    (setq tab-width 4)
	    (setq c-basic-offset 4)
	    (setq indent-tabs-mode nil)
	    (require 'php-align)
	    (php-align-setup)
	    (define-key c-mode-base-map "\C-ca" 'align-current)
            (require 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete) ;php-completionの補完実行キーバインドの設定
            (make-local-variable 'ac-sources)
            (setq ac-sources '(
                               ac-source-words-in-same-mode-buffers
                               ac-source-php-completion
                               ac-source-filename
                               ))))



(when (require 'flymake nil t)
  (custom-set-variables '(php-executable "/home/y/bin64/php"))
  (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)
  ;; PHP
  (when (not (fboundp 'flymake-php-init))
    (defun flymake-php-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local-file "-l"))))
    (setq flymake-allowed-file-name-masks
          (append
           flymake-allowed-file-name-masks
           '(("\.php[345]?$" flymake-php-init))))
    (setq flymake-err-line-patterns
          (cons
           '("\(\(?:Parse error\|Fatal error\|Warning\): .*\) in \(.*\) on line \([0-9]+\)" 2 3 nil 1)
           flymake-err-line-patterns)))
  
  (add-hook 'php-mode-hook
            '(lambda () (flymake-mode t)))

  )

(require 'inf-php)
