(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(add-hook 'css-mode-hook (function (lambda () (setq cssm-indent-function 'cssm-c-style-indenter))))
(add-hook 'css-mode-hook 'ac-css-mode-setup)

(defun ac-css-prefix ()
  (when (save-excursion (re-search-backward "\\_<\\(.+?\\)\\_>\\s *:.*\\=" nil t))
    (setq ac-css-property (match-string 1))
    (or (ac-prefix-symbol) (point))))

(defvar ac-source-css-property-names
  '((candidates . (loop for property in ac-css-property-alist
                        collect (car property)))))

(defun my-css-mode-hook ()
  (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-css-property-names))
(add-hook 'css-mode-hook 'my-css-mode-hook)


;; ;; CSS
(defun my-css-electric-pair-brace ()
  (interactive)
  (insert "{")(newline-and-indent)
  (newline-and-indent)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)(indent-for-tab-command)
  )

(defun my-semicolon-ret ()
  (interactive)
  (insert ";")
  (newline-and-indent))

;; ;; scss-mode
;; ;; https://github.com/antonj/scss-mode
(autoload 'scss-mode "scss-mode")
 (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;; (add-to-list 'auto-mode-alist '("\\.\\(scss\\|css\\)\\'" . scss-mode))
(add-hook 'scss-mode-hook 'ac-css-mode-setup)
(add-hook 'scss-mode-hook
          (lambda ()
            (define-key scss-mode-map "\M-{" 'my-css-electric-pair-brace)
            (define-key scss-mode-map ";" 'my-semicolon-ret)
            (setq css-indent-offset 2)
            (setq scss-compile-at-save nil)
            (setq ac-sources '(ac-source-yasnippet
                               ;; ac-source-words-in-same-mode-buffers
                               ac-source-words-in-all-buffer
                               ac-source-dictionary
                               ))
            ;;(flymake-mode t)
            ))
(add-to-list 'ac-modes 'scss-mode)
