(require 'anything-exuberant-ctags)
(require 'anything-startup)


; my-anything-filelist+
(defun my-anything-filelist+ ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-imenu     
     anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-files-in-current-dir+
     anything-c-source-locate
     )
   " *my-anything-filelist+*"))

(global-set-key "\C-l" 'my-anything-filelist+)

