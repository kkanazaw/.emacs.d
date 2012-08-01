(require 'anything-startup)


; my-anything-filelist+
(defun my-anything-filelist+ ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-files-in-current-dir+
     anything-c-source-locate
     anything-c-source-imenu)
   " *my-anything-filelist+*"))

(global-set-key "\C-l" 'my-anything-filelist+)

;;http://www.flatz.jp/archives/2172
;;kill-ring の最大値. デフォルトは 30.
(setq kill-ring-max 20)
;;anything で対象とするkill-ring の要素の長さの最小値.
;;デフォルトは 10.
(setq anything-kill-ring-threshold 5)
(global-set-key "\M-y" 'anything-show-kill-ring)
;;(global-set-key "\M-/" 'anything-dabbrev-expand)
