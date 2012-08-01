;;;;;;;
;;;;;;; SKK
;;;;;;;
(require 'skk-autoloads)
(setq default-input-method 'japanese-skk)

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
