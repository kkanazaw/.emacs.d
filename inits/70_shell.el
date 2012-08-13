;;パスワードの入力を隠す
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)


;; コントロールシーケンスを利用した色指定が使えるように
(autoload 'ansi-color-for-comint-mode-on "ansi-color"  "Set `ansi-color-for-comint-mode' to t." t)

(setenv "PAGER" "cat")

(add-hook 'shell-mode-hook
          '(lambda ()
             ;; zsh のヒストリファイル名を設定
             (setq comint-input-ring-file-name "~/.bash_history")
             ;; ヒストリの最大数
             (setq comint-input-ring-size 1024)
             ;; 既存の zsh ヒストリファイルを読み込み
             (comint-read-input-ring t)
             ;; zsh like completion (history-beginning-search)
             (local-set-key (kbd "M-p") 'comint-previous-matching-input-from-input)
             (local-set-key (kbd "M-n") 'comint-next-matching-input-from-input)
	     (local-set-key (kbd "C-r") 'anything-complete-shell-history)
	     (use-anything-show-completion 'anything-complete-shell-history
					   '(length anything-c-source-complete-shell-history))
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
        (setq unread-command-events (listify-key-sequence " "))))

;;補完
(require 'bash-completion)
(bash-completion-setup)
