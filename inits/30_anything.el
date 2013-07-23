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

