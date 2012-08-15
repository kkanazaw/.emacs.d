(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\|t\\|cgi\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
;;; cperl-mode is preferred to perl-mode
;;; "Brevity is the soul of wit" <foo at acm.org>
(defalias 'perl-mode 'cperl-mode)
 
(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-label-offset -4
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-tab-always-indent nil
      cperl-font-lock t)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (setq indent-tabs-mode nil)
               (setq tab-width nil)
 
               ; perl-completion
               (require 'auto-complete)
               (require 'perl-completion)
               (add-to-list 'ac-sources 'ac-source-perl-completion)
               (perl-completion-mode t)
              )))
 
; perl tidy
; sudo aptitude install perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))
(global-set-key "\C-ct" 'perltidy-region)
(global-set-key "\C-c\C-t" 'perltidy-defun)

;; ;; flymake (Emacs22から標準添付されている)
;; ;; http://d.hatena.ne.jp/antipop/20080701/1214838633
;; (require 'flymake)

;; ;; set-perl5lib
;; ;; 開いたスクリプトのパスに応じて、@INCにlibを追加してくれる
;; ;; 以下からダウンロードする必要あり
;; ;; http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el
;; (require 'set-perl5lib)

;; ;; エラー、ウォーニング時のフェイス
;; (set-face-background 'flymake-errline "red4")
;; (set-face-foreground 'flymake-errline "black")
;; (set-face-background 'flymake-warnline "yellow")
;; (set-face-foreground 'flymake-warnline "black")

;; ;; エラーをミニバッファに表示
;; ;; http://d.hatena.ne.jp/xcezx/20080314/1205475020
;; (defun flymake-display-err-minibuf ()
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no
;; 	  (flymake-current-line-no))
;;          (line-err-info-list
;; 	  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count
;; 	  (length line-err-info-list)))
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file
;; 		(flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file
;; 		(flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text
;; 		(flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line
;; 		(flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)))
;;       (setq count (1- count)))))

;; ;; Perl用設定
;; ;; http://unknownplace.org/memo/2007/12/21#e001
;; (defvar flymake-perl-err-line-patterns
;;   '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

;; (defconst flymake-allowed-perl-file-name-masks
;;   '(("\\.pl$" flymake-perl-init)
;;     ("\\.pm$" flymake-perl-init)
;;     ("\\.t$" flymake-perl-init)))

;; (defun flymake-perl-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "perl" (list "-wc" local-file))))

;; (defun flymake-perl-load ()
;;   (interactive)
;;   (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;;     (setq flymake-check-was-interrupted t))
;;   (ad-activate 'flymake-post-syntax-check)
;;   (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
;;   (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
;;   (set-perl5lib)
;;   (flymake-mode t))

;; (add-hook 'cperl-mode-hook 'flymake-perl-load)
