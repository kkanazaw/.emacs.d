(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

(require 'auto-complete-ruby)

(defun ruby-mode-hook-ruby-elecrtric ()
  (ruby-electric-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-elecrtric)

;; (require 'flymake)

;; (defun flymake-ruby-init ()
;;   (let* ((temp-file
;; 	  (flymake-init-create-temp-buffer-copy
;; 	   'flymake-create-temp-inplace))
;;          (local-file
;; 	  (file-relative-name
;; 	   temp-file
;; 	   (file-name-directory buffer-file-name))))
;;     (list "ruby" (list "-c" local-file))))
;; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
;; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

;; (defun ruby-mode-hook-flymake-init ()
;;   "Don't want flymake mode for ruby regions in rhtml files and also on read only files"
;;   (if (and (not (null buffer-file-name))
;;            (file-writable-p buffer-file-name))
;;       (flymake-mode-on)))
;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-flymake-init)

(require 'inf-ruby)
(require 'bundler)
