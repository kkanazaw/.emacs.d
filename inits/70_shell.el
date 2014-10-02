;; ============================================================
;; shell-mode
;; ============================================================

;; shell の存在を確認
(defun skt:shell ()
  (or (executable-find "bash")
      (executable-find "zsh")
      (executable-find "sh")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;;パスワードの入力を隠す
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)


;; コントロールシーケンスを利用した色指定が使えるように
(autoload 'ansi-color-for-comint-mode-on "ansi-color"  "Set `ansi-color-for-comint-mode' to t." t)

(setenv "PAGER" "cat")


(add-hook 'shell-mode-hook
          '(lambda ()
             ;; bash のヒストリファイル名を設定
             (setq comint-input-ring-file-name "~/.bash_history")
             ;; ヒストリの最大数
             (setq comint-input-ring-size 1024)
             ;; 既存の bash ヒストリファイルを読み込み
             (comint-read-input-ring t)
             ;; zsh like completion (history-beginning-search)
             (local-set-key (kbd "M-p") 'comint-previous-matching-input-from-input)
             (local-set-key (kbd "M-n") 'comint-next-matching-input-from-input)
	     (local-set-key (kbd "C-r") 'anything-complete-shell-history)
	     (use-anything-show-completion 'anything-complete-shell-history
					   '(length anything-c-source-complete-shell-history))
             (local-set-key (kbd "^") (lambda() (interactive)(comint-simple-send (get-buffer-process (get-buffer "*shell*")) "cdup")))

             ;; 色の設定
             (setq ansi-color-names-vector
                   ["#000000"           ; black
                    "#ff6565"           ; red
                    "#93d44f"           ; green
                    "#eab93d"           ; yellow
                    "#204a87"           ; blue
                    "#ce5c00"           ; magenta
                    "#89b6e2"           ; cyan
                    "#ffffff"]          ; white
                   )
             (ansi-color-for-comint-mode-on)
             )
          )

;;http://snarfed.org/automatically_close_completions_in_emacs_shell_comint_mode
;;
(defun comint-close-completions ()
  "Close the comint completions buffer.
Used in advice to various comint functions to automatically close
the completions buffer as soon as I'm done with it. Based on
Dmitriy Igrishin's patched version of comint.el."
  (if comint-dynamic-list-completions-config
      (progn
        (set-window-configuration comint-dynamic-list-completions-config)
        (setq comint-dynamic-list-completions-config nil))))

(defadvice comint-send-input (after close-completions activate)
  (comint-close-completions))

(defadvice comint-dynamic-complete-as-filename (after close-completions activate)
  (if ad-return-value (comint-close-completions)))

(defadvice comint-dynamic-simple-complete (after close-completions activate)
  (if (member ad-return-value '('sole 'shortest 'partial))
      (comint-close-completions)))

(defadvice comint-dynamic-list-completions (after close-completions activate)
    (comint-close-completions)
    (if (not unread-command-events)
        ;; comint's "Type space to flush" swallows space. put it back in.
        ;; (setq unread-command-events (listify-key-sequence " "))
      (setq unread-command-events (append
				   (listify-key-sequence (kbd "<backspace>"))
				   (listify-key-sequence (kbd "DEL"))
				   (listify-key-sequence(kbd "C-a"))
				   (listify-key-sequence(kbd "C-k"))
				   (listify-key-sequence(kbd "C-e"))
				   (listify-key-sequence(kbd "C-b"))
				   (listify-key-sequence(kbd "C-f"))
				   (listify-key-sequence(kbd "C-g"))
				   unread-command-events))
))

;;引数補完
;;(add-hook 'shell-mode-hook 'pcomplete-shell-setup)

(require 'bash-completion)
(require 'anything-bash-completion)
(bash-completion-setup)

(mapc (lambda (func) 
	  (remove-hook 'shell-dynamic-complete-functions func)
	  (remove-hook 'shell-command-complete-functions func)
	  ) '(bash-completion-dynamic-complete 
	      comint-replace-by-expanded-history 
	      shell-dynamic-complete-environment-variable 
	      shell-dynamic-complete-command 
	      shell-replace-by-expanded-directory 
	      shell-dynamic-complete-filename 
	      comint-dynamic-complete-filename))
(add-hook 'shell-dynamic-complete-functions
	  'my-bash-completion-dynamic-complete)
(add-hook 'shell-command-complete-functions
	  'my-bash-completion-dynamic-complete)

;; (require 'anything-zsh-screen)
;; (eval-after-load
;;     'shell
;;   '(define-key shell-mode-map "\C-i" 'anything-zsh-screen-simple-complete))


;; shell-modeでの補完 (for drive letter)
;; http://www.ceres.dti.ne.jp/~m-hase/emacs/dot_meadow.html
(setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}`'.,:()-")


;; ============================================================
;; ansi-term
;; ============================================================
(require 'multi-term)

(defvar my-shell-pop-key (kbd "C-x t"))
(defvar my-ansi-term-toggle-mode-key (kbd "<f2>"))

(defun my-term-switch-line-char ()
  "Switch `term-in-line-mode' and `term-in-char-mode' in `ansi-term'"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode 1))))

(defadvice anything-c-kill-ring-action (around my-anything-kill-ring-term-advice activate)
  "In term-mode, use `term-send-raw-string' instead of `insert-for-yank'"
  (if (eq major-mode 'term-mode)
      (letf (((symbol-function 'insert-for-yank) (symbol-function 'term-send-raw-string)))
        ad-do-it)
    ad-do-it))

(add-hook 'term-mode-hook
          '(lambda ()	    
            ;; shell-pop
            (define-key term-raw-map my-shell-pop-key 'shell-pop)
	    (define-key term-raw-map (kbd "C-l") nil)
	    (define-key term-raw-map (kbd "C-p") nil)
	    (define-key term-raw-map (kbd "C-n") nil)
	    ;;(define-key term-raw-map (kbd "C-a") nil)
	    (define-key term-raw-map (kbd "C-e") nil)
	    (define-key term-raw-map (kbd "C-w") nil)
	    (define-key term-raw-map (kbd "M-f") nil)
	    (define-key term-raw-map (kbd "C-f") nil)
	    (define-key term-raw-map (kbd "C-k") nil)
	    (define-key term-raw-map (kbd "M-w") nil)
	    (define-key term-raw-map (kbd "M-h") nil)
            ;; C-h を term 内文字削除にする
            (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
	    (define-key term-raw-map [backspace] 'term-send-backspace)
            ;; これがないと M-x できなかったり
            (define-key term-raw-map (kbd "M-x") 'nil)
            ;; コピー, 貼り付け
            (define-key term-raw-map (kbd "C-k")
              (lambda (&optional arg)
		(interactive "P") (funcall 'kill-line arg) (term-send-raw)))
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "M-y") 'anything-show-kill-ring)
	    (define-key term-raw-map (kbd "C-r") 'anything-complete-shell-history)
            ;; C-t で line-mode と char-mode を切り替える
            (define-key term-raw-map  my-ansi-term-toggle-mode-key 'my-term-switch-line-char)
            (define-key term-mode-map my-ansi-term-toggle-mode-key 'my-term-switch-line-char)
            ;; Tango!
            (setq ansi-term-color-vector
                  [unspecified
                   "#000000"           ; black
                   "#ff3c3c"           ; red
                   "#84dd27"           ; green
                   "#eab93d"           ; yellow
                   "#135ecc"           ; blue
                   "#f47006"           ; magenta
                   "#89b6e2"           ; cyan
                   "#ffffff"]          ; white
                  )
            ))

