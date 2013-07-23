(require 'color-moccur)
(require 'moccur-edit)

;;http://www.flatz.jp/archives/2172
;;kill-ring の最大値. デフォルトは 30.
(setq kill-ring-max 20)
;;anything で対象とするkill-ring の要素の長さの最小値.
;;デフォルトは 10.
(setq anything-kill-ring-threshold 5)
(global-set-key "\M-y" 'anything-show-kill-ring)
;;(global-set-key "\M-/" 'anything-dabbrev-expand)

(require 'view)
(defun all-mode-quit ()
  (interactive)
  (view-mode 1) (View-quit))


(require 'all-ext)

(when (require 'anything-c-moccur nil t)
    (setq
     ;; anything-c-moccur用 `anything-idle-delay'
     anything-c-moccur-anything-idle-delay 0.1
     ;; バッファの情報をハイライトする
     anything-c-moccur-higligt-info-line-flag t
     ;; 現在選択中の候補の位置を他のwindowに表示する
     anything-c-moccur-enable-auto-look-flag t
     ;; 起動時にポイントの位置の単語を初期パターンにする
     anything-c-moccur-enable-initial-pattern t))
(global-set-key (kbd "C-M-o")
                'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-c C-a") 'all-from-anything-occur)
(global-set-key (kbd "C-c C-q") 'all-mode-quit)

