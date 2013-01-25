(add-hook 'java-mode-hook
          (lambda ()
            ;; Make annotations comments
            (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
            (modify-syntax-entry ?@ "< b" java-mode-syntax-table)

            (setq tab-width 4)
            (setq tab-always-indent t)))

;; eclipse-java-style is the same as the "java" style (copied from
;; cc-styles.el) with the addition of (arglist-cont-nonempty . ++) to
;; c-offsets-alist to make it more like default Eclipse formatting -- function
;; arguments starting on a new line are indented by 8 characters
;; (++ = 2 x normal offset) rather than lined up with the arguments on the
;; previous line
(defconst eclipse-java-style
  '((c-basic-offset . 4)
    (c-comment-only-line-offset . (0 . 0))
    ;; the following preserves Javadoc starter lines
    (c-offsets-alist . ((inline-open . 0)
                        (topmost-intro-cont    . +)
                        (statement-block-intro . +)
                        (knr-argdecl-intro     . 5)
                        (substatement-open     . +)
                        (substatement-label    . +)
                        (label                 . +)
                        (statement-case-open   . +)
                        (statement-cont        . +)
                        (arglist-intro  . ++)
                        (arglist-close  . c-lineup-arglist)
                        (access-label   . 0)
                        (inher-cont     . c-lineup-java-inher)
                        (func-decl-cont . c-lineup-java-throws)
                        (arglist-cont-nonempty . ++)
                        )))
  "Eclipse Java Programming Style")

(c-add-style "eclipse" eclipse-java-style)

(setcdr (assoc 'java-mode c-default-style) "eclipse")

;; flymake configuration
(require 'flymake-cursor)
;; (add-hook 'java-mode-hook
;; 	  '(lambda ()
;; 	     (flymake-mode t)))
(when (load "flymake" t)
  (defun flymake-java-checkstyle-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "~/download/checkstyle-5.6/checkstyle.sh" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.java\\'" flymake-java-checkstyle-init)))

(add-hook 'java-mode-common-hook '(lambda ()
       (add-to-list 'ac-omni-completion-sources
                      (cons "\\." '(ac-source-semantic)))
       (add-to-list 'ac-omni-completion-sources
                      (cons "->" '(ac-source-semantic)))
       (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
))
