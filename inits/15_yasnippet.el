;;https://github.com/capitaomorte/yasnippet
(require 'yasnippet)
(require 'anything-c-yasnippet)
;;(yas/initialize)
;;(yas/load-directory "~/.emacs.d/elisp/yasnippet/snippets/")
(setq yas-snippet-dirs '("~/.emacs.d/elisp/yasnippet/snippets/"))
(setq yas/prompt-functions '(yas/dropdown-prompt))
(yas/global-mode 1)
