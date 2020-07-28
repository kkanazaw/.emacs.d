; mmm-mode in php
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
;; http://www.cozmixng.org/~kou/emacs/mmm

;; mmm-modeをカラフルに
;;(setq mmm-submode-decoration-level 2)

;; mmm-modeの前景色と背景色を入れ換える。
;(invert-face 'mmm-default-submode-face)
;; mmm-modeのフェイスを変更
;;(set-face-bold-p 'mmm-default-submode-face t)
;;(set-face-background 'mmm-default-submode-face "DarkSeaGreen")
;; 背景を無くする
(set-face-background 'mmm-default-submode-face nil)
;(set-face-background 'mmm-default-submode-face "navy")


;; (mmm-add-classes
;;  '((html-php
;;     :submode php-mode
;;     :front "<\\?\\(php\\)?"
;;     :back "\\?>")))
;; (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . html-mode))

;;http://d.hatena.ne.jp/CortYuming/20120719/p2
;; (mmm-add-classes
;;  '((html-css
;;     :submode scss-mode
;;     :front "<style[^>]*>[ \n]?*[ \n]?*</style>")))
;; (mmm-add-mode-ext-class nil "\\.html*" 'html-css)
(mmm-add-classes
 '((html-css
    :submode css-mode
    :front "<style[^>]*>"
    :back "</style>")))
(mmm-add-mode-ext-class nil "\\.html*" 'html-css)


(mmm-add-classes
 '((html-js
    :submode js-mode
    :front "<script[^>]*>"
    :back "</script>")))
(mmm-add-mode-ext-class nil "\\.html*" 'html-js)
