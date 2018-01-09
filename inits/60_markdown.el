(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.txt" . gfm-mode) auto-mode-alist))
(setq markdown-url-compose-char "*")
(add-hook 'markdown-mode-hook
  (lambda()
    (define-key markdown-mode-map (kbd "C-i") 'markdown-cycle)
    ))






