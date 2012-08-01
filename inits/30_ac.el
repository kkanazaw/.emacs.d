;;http://cx4a.org/software/auto-complete/manual.ja.html
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "/home/sanshiro/.emacs.d/elisp/ac-dict")
(setq ac-use-menu-map t)
(setq ac-use-comphist nil)
(setq ac-auto-start 3)
(setq ac-candidate-limit 20)

(global-set-key "\M-/" 'ac-start)
(define-key ac-mode-map (kbd "M-i") 'auto-complete)
(ac-flyspell-workaround)
;; C-n/C-p で候補を選択
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

