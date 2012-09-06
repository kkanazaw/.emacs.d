(require 'cl)
(require 'anything)
(require 'anything-match-plugin)

(defvar anything-c-source-bash-completion
'(
  (name . "Bash Completion")
  (candidates . (lambda()
		  (with-current-buffer (get-buffer " bash-completion")
		    (delete ""
			    (split-string
			     (buffer-substring-no-properties (point-min) (point-max))
			     "\n")))
		  ))
  (action . (("Insert" . anything-bash-insert-candidate)))
  ))

(defun anything-bash-insert-candidate (candidate)
  (lexical-let* ((start (comint-line-beginning-position))
	    (pos (point))
	    (tokens (bash-completion-tokenize start pos))
	    (parsed (bash-completion-process-tokens tokens pos))
	    (point (cdr (assq 'point parsed)))
	    (cword (cdr (assq 'cword parsed)))
	    (words (cdr (assq 'words parsed)))
	    (stub (nth cword words)))

    (delete-region (- pos (length stub)) pos)

    (if (string= stub "cd")
    	(insert (format "cd -%s" (first (split-string candidate))))
      (insert candidate)
      )
    ;; (insert candidate)
    )
  )

(defun anything-bash-completion()
 "My 'anything."
 (interactive)
 (anything-other-buffer '(anything-c-source-bash-completion) nil))


(defun my-bash-completion-dynamic-complete ()
  "Complete word at cursor using BASH completion.

This function is meant to be added into
`shell-dynamic-complete-functions' or
`shell-command-complete-functions'.  It uses `comint' to figure
out what the current command is and calls
`comint-dynamic-simple-complete' to do the completion.

If a match was found, it is displayed as is usual for comint
completion.  Return nil if no match was found."
  (when bash-completion-enabled
    (when (not (window-minibuffer-p))
      (message "Bash completion..."))
    (lexical-let* ( (start (comint-line-beginning-position))
	    (pos (point))
	    (tokens (bash-completion-tokenize start pos))
	    (open-quote (bash-completion-tokenize-open-quote tokens))
	    (parsed (bash-completion-process-tokens tokens pos))
	    (line (cdr (assq 'line parsed)))
	    (point (cdr (assq 'point parsed)))
	    (cword (cdr (assq 'cword parsed)))
	    (words (cdr (assq 'words parsed)))
	    (stub (nth cword words))
	    (completions nil)
	    ;; Override configuration for comint-dynamic-simple-complete.
	    ;; Bash adds a space suffix automatically.
	    (comint-completion-addsuffix nil))

      (with-current-buffer (get-buffer-create " bash-completion")
	(erase-buffer)
	)
      (cond 
       ((string= stub "cd")
       	     (with-current-buffer (get-buffer-create " bash-completion")
       			(erase-buffer)
       			(insert-file-contents-literally "/tmp/dirstack")
       			(setq completions (buffer-substring-no-properties (point-min) (point-max)))
       			)
       	     )
       ((eq t t) (setq completions (bash-completion-comm line point words cword open-quote)))
       )
      (if completions
      	  ;;(comint-dynamic-simple-complete stub completions)
      	  (anything-bash-completion)
      	;; no standard completion
      	;; try default (file) completion after a wordbreak
      	(my-bash-completion-dynamic-try-wordbreak-complete stub open-quote)
	)
      ))
)

(defun my-bash-completion-dynamic-try-wordbreak-complete (stub open-quote)
  "Try wordbreak completion on STUB if the complete completion failed.

Split STUB using the wordbreak list and apply compgen default
completion on the last part.  Return non-nil if a match was found.

If STUB is quoted, the quote character, ' or \", should be passed
to the parameter OPEN-QUOTE.

This function is not meant to be called outside of
`bash-completion-dynamic-complete'."
  (let* ((wordbreak-split (bash-completion-last-wordbreak-split stub))
	 (before-wordbreak (car wordbreak-split))
	 (after-wordbreak (cdr wordbreak-split)))
    (when (car wordbreak-split)
      (bash-completion-send (concat
			     (bash-completion-cd-command-prefix)
			     "compgen -o default -- "
			     (bash-completion-quote after-wordbreak)))

      (anything-bash-completion)
      )))

(defun bash-completion-require-process ()
  "Return the bash completion process or start it.

If a bash completion process is already running, return it.

Otherwise, create a bash completion process and return the
result.  This can take a since bash needs to start completely
before this function returns to be sure everything has been
initialized correctly.

The process uses `bash-completion-prog' to figure out the path to
bash on the current system.

To get an environment consistent with shells started with `shell',
the first file found in the following list are sourced if they exist:
 ~/.emacs_bash.sh
 ~/.emacs.d/init_bash.sh
Or, to be more exact, ~/.emacs_$(basename `bash-completion-prog').sh)
and ~/.emacs.d/init_$(basename `bash-completion-prog').sh)

To allow scripts to tell the difference between shells launched
by bash-completion, the environment variable EMACS_BASH_COMPLETE
is set to t."
  (if (bash-completion-is-running)
      bash-completion-process
    ;; start process
    (let ((process) (oldterm (getenv "TERM")))
      (unwind-protect
	  (progn
	    (setenv "EMACS_BASH_COMPLETE" "t")
	    (setenv "TERM" "dumb")
	    (setq process
		  (start-process
		   "*bash-completion*"
		   " bash-completion"
		   bash-completion-prog
		   "--noediting"))
	    (set-process-query-on-exit-flag process nil)
	    (let* ((shell-name (file-name-nondirectory bash-completion-prog))
		   (startfile1 (concat "~/.emacs_" shell-name ".sh"))
		   (startfile2 (concat "~/.emacs.d/init_" shell-name ".sh")))
	      (cond
	       ((file-exists-p startfile1)
		(process-send-string process (concat ". " startfile1 "\n")))
	       ((file-exists-p startfile2)
		(process-send-string process (concat ". " startfile2 "\n")))))
	    (bash-completion-send "PS1='\v'" process bash-completion-initial-timeout)
	    (bash-completion-send "function __bash_complete_wrapper { eval $__BASH_COMPLETE_WRAPPER; }" process)
	    ;; attempt to turn off unexpected status messages from bash
	    ;; if the current version of bash does not support these options,
	    ;; the commands will fail silently and be ignored.
	    (bash-completion-send "export HISTCONTROL=ignoreboth" process)
	    (bash-completion-send "shopt -u checkjobs" process)
	    (bash-completion-send "shopt -u mailwarn" process)
	    (bash-completion-send "export MAILCHECK=-1" process)
	    (bash-completion-send "export -n MAIL" process)
	    (bash-completion-send "export -n MAILPATH" process)
	    (bash-completion-send "export PROMPT_COMMAND=''" process)
	    ;; some bash completion functions use quote_readline to double-quote
	    ;; strings - which compgen understands but only in some environment.
	    ;; disable this dreadful business to get a saner way of handling
	    ;; spaces. Noticed in bash_completion v1.872.
	    (bash-completion-send "function quote_readline { echo \"$1\"; }" process)
	    (bash-completion-send "complete -p" process)
	    (bash-completion-build-alist (process-buffer process))
	    (setq bash-completion-process process)
	    (setq process nil)
	    bash-completion-process)
	;; finally
	(progn
	  (setenv "EMACS_BASH_COMPLETE" nil)
	  (setenv "TERM" oldterm)
	  (when process
	    (condition-case err
		(bash-completion-kill process)
	      (error nil))))))))


(defun bash-completion-send (commandline &optional process timeout)
  "Send a command to the bash completion process.

COMMANDLINE should be a bash command, without the final newline.

PROCESS should be the bash process, if nil this function calls
`bash-completion-require-process' which might start a new process.

TIMEOUT is the timeout value for this operation, if nil the value of
`bash-completion-process-timeout' is used.

Once this command has run without errors, you will find the result
of the command in the bash completion process buffer."
  ;;(message commandline)
  (let ((process (or process (bash-completion-require-process)))
	(timeout (or timeout bash-completion-process-timeout)))
    (with-current-buffer (process-buffer process)
      (erase-buffer)
      (process-send-string process (concat " " commandline "\n"))
      (while (not (progn (goto-char 1) (search-forward "\v" nil t)))
	(unless (accept-process-output process timeout)
	  (error "Timeout while waiting for an answer from bash-completion process")))
      (goto-char (point-max))
      (delete-backward-char 1))))

(provide 'anything-bash-completion)