;;http://cx4a.org/software/auto-complete/manual.ja.html
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/sanshiro/.emacs.d/elisp/ac-dict")
(ac-config-default)

(setq ac-use-menu-map t)
(setq ac-use-comphist nil)
(setq ac-auto-start 2)
(setq ac-candidate-limit 20)

(global-set-key "\M-/" 'ac-start)
(define-key ac-mode-map (kbd "M-i") 'auto-complete)
(ac-flyspell-workaround)
;; C-n/C-p で候補を選択
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-i") nil) ;;C-iで決定されないよう設定（C-iでyasnippetを実行）

(require 'ajc-java-complete-config)
(set 'ajc-tag-file "~/.emacs.d/elisp/ajc.tag")
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)
