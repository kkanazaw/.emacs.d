;; (cond
;;   ((>= emacs-major-version '23)
;;     (progn
;;       (require 'zlc)
;;       (setq zlc-select-completion-immediately t))))

;; (let ((map minibuffer-local-map))
;;   ;; (define-key map (kbd "<backtab>") 'zlc-select-previous)
;;   ;; (define-key map (kbd "S-<tab>") 'zlc-select-previous)
;;   ;; (define-key map (kbd "C-p") 'zlc-select-previous-vertical)
;;   ;; (define-key map (kbd "C-n") 'zlc-select-next-vertical)
;;   ;; (define-key map (kbd "C-b") 'zlc-select-previous)
;;   ;; (define-key map (kbd "C-f") 'zlc-select-next)

;;   ;;; like menu select
;;   (define-key map (kbd "<down>")  'zlc-select-next-vertical)
;;   (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
;;   (define-key map (kbd "<right>") 'zlc-select-next)
;;   (define-key map (kbd "<left>")  'zlc-select-previous)

;;   ;;; reset selection
;;   (define-key map (kbd "C-c") 'zlc-reset)
;; )
