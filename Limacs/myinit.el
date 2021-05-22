(global-set-key "\C-o" 'compile)
(global-set-key (kbd "C-c C-.") 'org-mark-ring-goto)
(global-set-key (kbd "C-M-,") 'menu-bar-mode)
(global-set-key (kbd "C-M-q") 'ivy-switch-buffer-kill)

(setq colon-double-space t)
        ;; tell the Emacs fill commands to insert two spaces after a colon:

        ;; Rebind 'C-x C-b' for 'buffer-menu'
        (global-set-key "\C-x\C-b" 'buffer-menu)
        ;; which not only lists the buffers, but moves point into that window

        ;; Set cursor color
        (set-cursor-color "white")

        ;; Set mouse color
        (set-mouse-color "white")

        ;;(setq make-backup-files nil)

        ;;close tool bar 
        (setq inhibit-startup-message t)
        (tool-bar-mode -1)

        ;;close menu bar
        (menu-bar-mode -1)

        ;;close toggle sroll bar
        (toggle-scroll-bar -1)
        ;; parse
        (show-paren-mode t)

        ;; user y and n instead of yes and no 
        (fset 'yes-or-no-p 'y-or-n-p)

        ;; open line number at left side
        ;;  (global-linum-mode 1)

        ;; emacsclient -a "" -c
        ;; shortcut to open emacsclient settings in terminal

        ;; set the meta-key to be super key
        ;; (setq  x-meta-keysym 'super
        ;;        x-super-keysym 'meta)

        ;; open terminal 
        (global-set-key "\C-\M-x" 'term)

        ;; open  eshell
        (global-set-key "\C-x\ \C-x" 'shell)

        ;;open init.el file with f1
        (defun open-my-init-file()
          (interactive)
          (find-file "~/.emacs.d/init.el"))
        (global-set-key (kbd "<f1>") 'open-my-init-file)

        ;;open myinit.org file  with f2
        (defun open-my-init-org-file()
          (interactive)
          (find-file "~/Dropbox/cs/Limacs/myinit.org"))
        (global-set-key (kbd "<f2>") 'open-my-init-org-file)

        ;;open .bashrc file with f3
        (defun open-my-bash-file()
          (interactive)
          (find-file "~/.bashrc"))
        (global-set-key (kbd "<f3>") 'open-my-bash-file)

        ;;open .bashrc file with f4
        (defun open-my-tagsnote-file()
          (interactive)
          (find-file "~/Dropbox/Note/Note.org.gpg"))
        (global-set-key (kbd "<f4>") 'open-my-tagsnote-file)


        ;; trun off cl warning
        (setq byte-compile-warnings '(cl-functions))

        ;; backup oder
        (setq backup-directory-alist `(("." . "~/.emacs.d/backup")))
        (setq backup-by-copying t)

        ;;M-x toggle-truncate-line
       ;; off the word wrap 是否移动换行
       (toggle-truncate-lines 1)

       ;; open window horizontally default
       (setq split-height-threshold nil)
       (setq split-width-threshold 0 )


        ;; automatically update file
       (global-auto-revert-mode t)

  ;;M-n select-current-line
    (defun select-current-line ()
      "Select the current line"
      (interactive)
      (end-of-line) ; move to end of line
      (set-mark (line-beginning-position)))
    (global-set-key (kbd "M-n") 'select-current-line)

;; read only file
  (global-set-key (kbd "C-M-o") 'read-only-mode)

(setq EMACS_DIR "~/.emacs.d/")
(setenv "JAVA_HOME" "/usr/lib/jvm/java-11-openjdk-amd64")

(use-package dap-mode
  :ensure t
  :after (lsp-mode)
  :functions dap-hydra/nil
  :config
  (require 'dap-java)
  :bind (:map lsp-mode-map
         ("<f5>" . dap-debug)
         ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)
    (dap-session-created . (lambda (&_rest) (dap-hydra)))
    (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))))

(use-package dap-java :ensure nil)

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :ensure t
  :commands lsp-treemacs-errors-list
  :bind (:map lsp-mode-map
         ("M-9" . lsp-treemacs-errors-list)))

(use-package treemacs
  :ensure t
  :commands (treemacs)
  :after (lsp-mode))

(use-package lsp-ui
:ensure t
:after (lsp-mode)
:bind (:map lsp-ui-mode-map
         ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
         ([remap xref-find-references] . lsp-ui-peek-find-references))
:init (setq lsp-ui-doc-delay 1.5
      lsp-ui-doc-position 'bottom
	  lsp-ui-doc-max-width 100
))

(use-package helm-lsp
:ensure t
:after (lsp-mode)
:commands (helm-lsp-workspace-symbol)
:init (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))

(use-package lsp-mode
:ensure t
:hook (
   (lsp-mode . lsp-enable-which-key-integration)
   (java-mode . #'lsp-deferred)
)
:init (setq 
    lsp-keymap-prefix "C-c l"              ; this is for which-key integration documentation, need to use lsp-mode-map
    lsp-enable-file-watchers nil
    read-process-output-max (* 1024 1024)  ; 1 mb
    lsp-completion-provider :capf
    lsp-idle-delay 0.500
)
:config 
    (setq lsp-intelephense-multi-root nil) ; don't scan unnecessary projects
    (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root (gethash 'iph lsp-clients)) nil))
	(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
)

(use-package lsp-java 
:ensure t
:config (add-hook 'java-mode-hook 'lsp))

;; (setq lsp-clangd-executable "clangd-9.0")
;; (setq lsp-clients-clangd-executable "clangd-9.0")

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

  (when (cl-find-if-not #'package-installed-p package-selected-packages)
    (package-refresh-contents)
    (mapc #'package-install package-selected-packages))

  ;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
  (helm-mode)
  (require 'helm-xref)
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini)

  (which-key-mode)
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'cpp-mode-hook 'lsp)

  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil
        company-idle-delay 0.0
        company-minimum-prefix-length 1
        lsp-idle-delay 0.1 ;; clangd is fast
        ;; be more ide-ish
        lsp-headerline-breadcrumb-enable t)

  (with-eval-after-load 'lsp-mode
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
    (require 'dap-cpptools)
    (yas-global-mode))

;; (use-package lsp-jedi
;;   :ensure t
;;   :config
;;   (with-eval-after-load "lsp-mode"
;;     (add-to-list 'lsp-disabled-clients 'pyls)
;;     (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package yasnippet-snippets
  :ensure t
  :config)

;; (use-package rtags
;;   :ensure t
;;   :config
;;   (rtags-enable-standard-keybindings)
;;  (setq rtags-autostart-diagnostics t)
;;  (rtags-diagnostics)
;;  (setq rtags-completion-enabled t)
;;  (define-key c-mode-base-map (kbd "M-.")
;;    (function rtags-find-symbol-at-point))
;;  (define-key c-mode-base-map (kbd "M-,")
;;    (function rtags-find-references-at-point))
;;  )

;; (use-package cmake-ide
;;   :ensure t
;;   :config
;;   (cmake-ide-setup))

(setq path-to-ctags "/usr/local/bin/ctags")
 (defun create-tags (dir-name)
   "Create tags file."
   (interactive "DDirectory: ")
   (shell-command
    (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
 )
(defadvice find-tag (around refresh-etags activate)
  "Rerun etags and reload tags if tag not found and redo find-tag.              
  If buffer is modified, ask about save before running etags."
 (let ((extension (file-name-extension (buffer-file-name))))
   (condition-case err
   ad-do-it
     (error (and (buffer-modified-p)
         (not (ding))
         (y-or-n-p "Buffer is modified, save it? ")
         (save-buffer))
        (er-refresh-etags extension)
        ad-do-it))))

(defun er-refresh-etags (&optional extension)
"Run etags on all peer files in current dir and reload them silently."
(interactive)
(shell-command (format "etags *.%s" (or extension "el")))
(let ((tags-revert-without-query t))  ; don't query, revert silently          
  (visit-tags-table default-directory nil)))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(with-eval-after-load 'company
  (add-hook 'company-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(use-package company-irony-c-headers
  :ensure t)

(use-package flycheck-irony
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(use-package irony-eldoc
  :ensure t
  :config
  (add-hook 'irony-mode-hook #'irony-eldoc))

(use-package eglot
  :ensure t
  :config)

 (require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package python
  :ensure t
  ;;        :custom
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("/usr/bin/python3.6" . python-mode)
  :config
  (setq indent-tabs-mode nil)
  (setq python-indent-offset 4)
  (use-package py-autopep8
    :ensure t
    :hook ((python-mode . py-autopep8-enable-on-save))
    ))

(use-package company-jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook (lambda ()
                                (add-to-list (make-local-variable 'company-backends) 'company-jedi))))


(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq elpy-rpc-backend "jedi"))

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck ;; add the flycheck package
    material-theme
    ein ;; add the ein package (Emacs ipython notebook)
    py-autopep8))

(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "-i --simple-prompt")

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt")

(defun python-shell-send-region-or-line nil
  "Sends from python-mode buffer to a python shell, intelligently."
  (interactive)
  (cond ((region-active-p)
     (setq deactivate-mark t)
     (python-shell-send-region (region-beginning) (region-end))
 ) (t (python-shell-send-current-statement))))

(defun python-shell-send-current-statement ()
"Send current statement to Python shell.
Taken from elpy-shell-send-current-statement"
(interactive)
(let ((beg (python-nav-beginning-of-statement))
    (end (python-nav-end-of-statement)))
(python-shell-send-string (buffer-substring beg end)))
(python-nav-forward-statement))

(use-package python-mode
:ensure t
:hook (python-mode . lsp-deferred))

;;  (use-package jupyter)

;; (let ((client (jupyter-kernel-client)))
;;   (jupyter-comm-initialize client "kernel1234.json")
;;   (jupyter-start-channels client))

;; (use-package simple-httpd)
;;   (require 'simple-httpd)
;;   (setq httpd-root "/var/www")
;;   (httpd-start)

;; (use-package edit-server)
;;   (require 'edit-server)
;;   (edit-server-start)
;;   (load-file "~/.emacs.d/packages/jupyterlab_emacs/edit_server_jupyterlab.el")

(use-package js2-mode
  :ensure t
  ;;    :ensure ac-js2
  :mode (("\\.js\\'" . js2-mode)
         ("\\.json\\'" . javascript-mode))
  :init
  ;;  (setq-default js2-basic-offset 2)
  (setq-default js2-global-externs '("module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__d\
irname" "console" "JSON"))
  (progn
    (add-hook 'js-mode-hook 'js2-minor-mode)
    (add-hook 'js2-mode-hook 'ac-js2-mode)
    )
  )

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (add-to-list (make-local-variable 'company-backends)
               'company-files)
  (company-mode +1))

(add-hook 'js2-mode-hook #'setup-tide-mode)

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package prettier-js
  :ensure t
  :hook ((js2-mode . prettier-js-mode))
  :config
  (setq prettier-js-args '("--trailing-comma" "all"
                           "--bracket-spacing" "false")))

(use-package js2-refactor
      :ensure t
      :config
      (progn
        (js2r-add-keybindings-with-prefix "C-c C-m")
        ;; eg. extract function with `C-c C-m ef`.
        (add-hook 'js2-mode-hook #'js2-refactor-mode)))

  (use-package xref-js2
    :ensure t)

    (use-package tern
      :ensure tern
      :ensure tern-auto-complete
      :config
      (progn
        (add-hook 'js-mode-hook (lambda () (tern-mode t)))
        (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
        (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
        ;;(tern-ac-setup)
        ))

(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)

    ;; use web-mode for .jsx files
    (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))


    ;; turn on flychecking globally
    (add-hook 'after-init-hook #'global-flycheck-mode)

    ;; disable jshint since we prefer eslint checking
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(javascript-jshint)))

    ;; use eslint with web-mode for jsx files
    (flycheck-add-mode 'javascript-eslint 'web-mode)

    ;; customize flycheck temp file prefix
    (setq-default flycheck-temp-prefix ".flycheck")

    ;; disable json-jsonlist checking for json files
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(json-jsonlist)))

(use-package ob-typescript
:ensure t)

(use-package emmet-mode
  :ensure t
  :config)
        ;;;;;;;;;;;;;;
                                        ;emmet-mode
        ;;;;;;;;;;;;;
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)


(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode)
         ("\\.erb\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-css-colorization t)
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "royalblue")
  (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "powderblue")
  (set-face-attribute 'web-mode-doctype-face nil :foreground "lightskyblue")
  (setq web-mode-content-types-alist
        '(("vue" . "\\.vue\\'")))
  (use-package company-web
    :ensure t)
  (add-hook 'web-mode-hook (lambda()
                             (cond ((equal web-mode-content-type "html")
                                    (my/web-html-setup)))
                             )))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-to-list 'exec-path "/opt/local/bin")
(setenv "PATH" (mapconcat 'identity exec-path ":"))

(defun my/web-vue-setup ()
  " Setup for web-mode vue files."
  (message "web-mode for vue setup")
  (setup-tide-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (my/use-eslint-from-node-modules)
  (flycheck-select-checker 'javascript-eslint)
  (flycheck-mode)
  (add-hook 'web-mode-hook #'setup-tide-mode)
  (add-hook 'web-mode-hook #'prettier-js-mode)
  (add-to-list (make-local-variable 'company-backends)
               '(company-tide company-web-html company-files company-css))
  )

(defun my/use-eslint-from-node-modules ()
;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(let* ((root (locate-dominating-file
(or (buffer-file-name) default-directory)
"node_modules"))
(eslint (and root
(expand-file-name "node_modules/eslint/bin/eslint.js"
root))))
(when (and eslint (file-executable-p eslint))
(setq-local flycheck-javascript-eslint-executable eslint))))

(use-package haskell-mode
:ensure t
:config
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
)

;;; babel_haskell.el --- babel for haskell in src    -*- lexical-binding: t; -*-

;; Copyright (C) 2020  sx

;; Author: sx <sx@sx>
;; Keywords: tools, abbrev


(defun send-to-haskell/file-with-buffer (file-name buffer)
  "Load FILE-NAME in a REPL session and associate it with BUFFER."
  (haskell-interactive-mode-reset-error (haskell-session))
  (haskell-process-file-loadish
   (format "load \"%s\"" (replace-regexp-in-string
                          "\""
                          "\\\\\""
                          file-name))
   nil
   buffer))

(defun send-to-haskell/org-src-block (&optional arg)
  "Tangle the current Org mode source block and load it in a REPL session.
With one universal prefix argument, only tangle the block at point."
  (interactive "P")
  (let* ((src-block
          (cond ((string= major-mode "org-mode")
                 ;; In an Org mode buffer, is the cursor in a source block?
                 (let ((info (org-babel-get-src-block-info t)))
                   (if info
                       (list info nil (current-buffer))
                     nil)))
                (org-src-mode
                 ;; In a transient source code buffer.
                 (list org-src--babel-info (current-buffer)
                       (org-src--source-buffer)))
                (t
                 ;; Not in an Org mode source block or transient code buffer.
                 nil)))
         (is-haskell-src
          (and src-block (string= "haskell" (nth 0 (nth 0 src-block))))))
    (unless is-haskell-src
      (user-error "Not in a Haskell source code block"))
    (when is-haskell-src
      (let* ((info (nth 0 src-block))
             (code-buffer (nth 1 src-block))
             (org-buffer (nth 2 src-block))
             (lang (nth 0 info))
             (contents (nth 1 info))
             (params (nth 2 info))
             (tangle-to (cdr (assq :tangle params)))
             (posn (nth 5 info)))
        ;; Tangle the relevant code block(s) and get the tangled file name.
        (let ((out-file
               (cond ((string= tangle-to "no")
                      ;; Tangle this *single block* to a temporary file
                      (let* ((tmp-prefix "haskell-load-")
                             (tmp-suffix ".hs")
                             (tmp-file (concat
                                        (org-babel-temp-file tmp-prefix)
                                        tmp-suffix)))
                        (with-current-buffer org-buffer
                          (goto-char posn)
                          (let ((tangled-files
                                 (org-babel-tangle '(4) tmp-file)))
                            (message "Tangled: %s" tangled-files)
                            (nth 0 tangled-files)))))
                     (t
                      ;; Tangle all relevant blocks to a specified file
                      (with-current-buffer org-buffer
                        (goto-char posn)
                        ;; If `arg' is '(4), only tangle this single block.
                        (let* ((arg (if (equal arg '(4)) '(4) '(16)))
                               (tangled-files
                                (org-babel-tangle arg "haskell")))
                          (message "Tangled: %s" tangled-files)
                          (nth 0 tangled-files)))))))
          ;; Now visit this tangled file and load it in ghci.
          (if code-buffer
              ;; There is an existing code buffer, use a temporary buffer to
              ;; visit the tangled file.
              (with-temp-buffer
                (insert-file-contents out-file t)
                (send-to-haskell/file-with-buffer out-file code-buffer))
            ;; No existing code buffer, visit the file normally.
            ;; Set `NOWARN' to `t' to avoid prompting the user to reread the
            ;; file if the contents (on disk) have changed.
            (let ((tangled-buffer (find-file-noselect out-file t)))
              (with-current-buffer tangled-buffer
                ;; Ensure the buffer name starts and ends with an asterisk.
                (let ((buf-name (buffer-name)))
                  (unless (and (string-prefix-p "*" buf-name)
                               (string-suffix-p "*" buf-name))
                    (rename-buffer (concat "*" buf-name "*"))))
                (send-to-haskell/file-with-buffer out-file tangled-buffer))))
          nil)))))

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(setq x-select-enable-primary t)
(setq select-enable-primary t)

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; use xsel to copy/paste in emacs-nox
(unless window-system
  (when (getenv "DISPLAY")
    (defun xsel-cut-function (text &optional push)
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    (defun xsel-paste-function()
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output )))
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ))

(defun move-line (n)
      "Move the current line up or down by N lines."
      (interactive "p")
      (setq col (current-column))
      (beginning-of-line) (setq start (point))
      (end-of-line) (forward-char) (setq end (point))
      (let ((line-text (delete-and-extract-region start end)))
        (forward-line n)
        (insert line-text)
        ;; restore point to original column in moved line
        (forward-line -1)
        (forward-char col)))

    (defun move-line-up (n)
      "Move the current line up by N lines."
      (interactive "p")
      (move-line (if (null n) -1 (- n))))

    (defun move-line-down (n)
      "Move the current line down by N lines."
      (interactive "p")
      (move-line (if (null n) 1 n)))


    (defun move-region (start end n)
      "Move the current region up or down by N lines."
      (interactive "r\np")
      (let ((line-text (delete-and-extract-region start end)))
        (forward-line n)
        (let ((start (point)))
          (insert line-text)
          (setq deactivate-mark nil)
          (set-mark start))))

    (defun move-region-up (start end n)
      "Move the current line up by N lines."
      (interactive "r\np")
      (move-region start end (if (null n) -1 (- n))))

    (defun move-region-down (start end n)
      "Move the current line down by N lines."
      (interactive "r\np")
      (move-region start end (if (null n) 1 n)))


  (defun move-line-region-up (&optional start end n)
    (interactive "r\np")
    (if (use-region-p) (move-region-up start end n) (move-line-up n)))

  (defun move-line-region-down (&optional start end n)
    (interactive "r\np")
    (if (use-region-p) (move-region-down start end n) (move-line-down n)))

;; don't work in SRC block

  (global-set-key (kbd "M-<up>") 'move-line-region-up)
  (global-set-key (kbd "M-<down>") 'move-line-region-down)

(use-package doom-themes
:ensure t 
:init 
(load-theme 'doom-palenight t))


;; (use-package heaven-and-hell
;;   :ensure t
;;   :init
;;   (setq heaven-and-hell-theme-type 'dark)
;;   (setq heaven-and-hell-themes
;;         '((light . doom-acario-light)
;;           (dark . doom-palenight)))
;;   :hook (after-init . heaven-and-hell-init-hook)
;;   :bind (("C-c <f6>" . heaven-and-hell-load-default-theme)
;;          ("<f6>" . heaven-and-hell-toggle-theme)))

;;  copy region or whole line
(global-set-key "\M-w"
  (lambda ()
    (interactive)
    (if mark-active
        (kill-ring-save (region-beginning)
        (region-end))
      (progn
       (kill-ring-save (line-beginning-position)
       (line-end-position))
       (message "copied line")))))


  ;; kill region or whole line
  (global-set-key "\C-w"
  (lambda ()
    (interactive)
    (if mark-active
        (kill-region (region-beginning)
     (region-end))
      (progn
       (kill-region (line-beginning-position)
    (line-end-position))
       (message "killed line")))))

(setq is-alpha nil)
(defun transform-window (a ab)
  (set-frame-parameter (selected-frame) 'alpha (list a ab))
  (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
  )
(global-set-key [(f8)] (lambda()
                         (interactive)
                         (if is-alpha
                             (transform-window 100 100)
                           (transform-window 75 50))
                         (setq is-alpha (not is-alpha))))

;;switch dictionaries between German and English with F9 key
(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "deutsch8") "english" "deutsch8")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))
(global-set-key (kbd "<f9>")   'fd-switch-dictionary)

(defvar *echo-keys-last* nil "Last command processed by `echo-keys'.")

(defun echo-keys-mode ()
  (interactive)
  (if (member 'echo-keys-hook pre-command-hook)
      (progn
        (remove-hook 'pre-command-hook 'echo-keys-hook)
        (dolist (window (window-list))
          (when (eq (window-buffer window) (get-buffer "*echo-key*"))
            (delete-window window))))
    (progn
      (add-hook 'pre-command-hook 'echo-keys-hook)
      (delete-other-windows)
      (split-window nil (- (window-width) 8) t)
      (other-window 1)
      (switch-to-buffer (get-buffer-create "*echo-key*"))
      (set-window-dedicated-p (selected-window) t)
      (other-window 1))))

(defun echo-keys-hook ()
  (let ((deactivate-mark deactivate-mark))
    (when (this-command-keys)
      (with-current-buffer (get-buffer-create "*echo-key*")
        (goto-char (point-max))
        ;; self  self
        ;; self  other \n
        ;; other self  \n
        ;; other other \n
        (unless (and (eq 'self-insert-command *echo-keys-last*)
                     (eq 'self-insert-command this-command))
          (insert "\n"))
        (if (eql this-command 'self-insert-command)
            (let ((desc (key-description (this-command-keys))))
              (if (= 1 (length desc))
                  (insert desc)
                (insert " " desc " ")))
          (insert (key-description (this-command-keys)))
          )
        (setf *echo-keys-last* this-command)
        (dolist (window (window-list))
          (when (eq (window-buffer window) (current-buffer))
            ;; We need to use both to get the effect.
            (set-window-point window (point))
            (end-of-buffer)))))))

(provide 'echo-keys)

;; (use-package cnfonts
;; :ensure t
;; :config )

(require 'cnfonts)
 ;; 让 cnfonts 随着 Emacs 自动生效。
 (cnfonts-enable)
 ;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
(cnfonts-set-spacemacs-fallback-fonts)

(require 'evil)
(evil-mode 1)

(use-package mu4e
      :ensure nil
      :load-path "/usr/share/emacs/site-lisp/mu4e/"
      ;; :defer 20 ; Wait until 20 seconds after startup
      :config

      ;; This is set to 't' to avoid mail syncing issues when using mbsync
      (setq mu4e-change-filenames-when-moving t)

      ;; Refresh mail using isync every 10 minutes
      (setq mu4e-update-interval (* 10 60))
      (setq mu4e-get-mail-command "mbsync -a")
      (setq mu4e-maildir "~/Maildir"))

      ;; Make sure plain text mails flow correctly for recipients
      (setq mu4e-compose-format-flowed t)

      ;; Configure the function to use for sending mail
    (setq message-send-mail-function 'smtpmail-send-it)

    (setq mu4e-compose-signature
          (concat
           "Best regrads\n"
           "Silin Zhao")
          )

    (setq mu4e-contexts
          (list
           ;; Work account
           (make-mu4e-context
            :name "Gmail"
            :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
            :vars '((user-mail-address . "scofild429@gmail.com")
                    (user-full-name    . "Silin Zhao")
                    (smtpmail-smtp-server  . "smtp.gmail.com")
                    (smtpmail-smtp-service . 465)
                    (smtpmail-stream-type  . ssl)
  ;;                  (mu4e-drafts-folder  . "/Gmail/Drafts")
                    ;;                    (mu4e-sent-folder  . "/Gmail/Sent")
;;                    (mu4e-refile-folder  . "/Gmail/Inbox")
;;                    (mu4e-trash-folder  . "/Gmail/Trash")
                    ))
           ;; (make-mu4e-context
           ;;  :name "QQ"
           ;;  :match-func
           ;;  (lambda (msg)
           ;;    (when msg
           ;;      (string-prefix-p "/QQ" (mu4e-message-field msg :maildir))))
           ;;  :vars '((user-mail-address . "364638790@qq.com")
           ;;          (user-full-name    . "Silin Zhao")
           ;;          (smtpmail-smtp-server  . "smtp.qq.com")
           ;;          (smtpmail-smtp-service . 465)
           ;;          (smtpmail-stream-type  . ssl)
           ;;          (mu4e-drafts-folder  . "/QQ/Drafts")
           ;;          (mu4e-sent-folder  . "/QQ/Sent Messages")
           ;;          (mu4e-refile-folder  . "/QQ/Inbox")
           ;;          (mu4e-trash-folder  . "/QQ/Deleted Messages")))
           (make-mu4e-context
            :name "Outlook"
            :match-func
            (lambda (msg)
              (when msg
                (string-prefix-p "/Outlook" (mu4e-message-field msg :maildir))))
            :vars '((user-mail-address . "mscofild429@outlook.com")
                    (user-full-name    . "Silin Zhao")
                    (smtpmail-smtp-server  . "smtp.office365.com")
                    (smtpmail-smtp-service . 465)
                    (smtpmail-stream-type  . ssl)
                    (mu4e-drafts-folder  . "/Outlook/Drafts")
  ;;                  (mu4e-sent-folder  . "/Outlook/Sent")
                    (mu4e-refile-folder  . "/Outlook/Inbox")
                    (mu4e-trash-folder  . "/Outlook/Deleted")))
           ))

    (setq mu4e-maildir-shortcuts
          '(("/Gmail/Inbox" . ?i)
            ("/Gmail/[Gmail]/Sent Mail" . ?s)
            ("/Gmail/[Gmail]/Drafts" . ?d)
            ("/Gmail/[Gmail]/All Mail" . ?g)
            ("/QQ/Inbox" . ?I)
            ("/QQ/Sent Messages" . ?S)
            ("/QQ/*" . ?q)
            ("/Outlook/*" . ?O)
            ("/Outlook/Sent" . ?K)
            ("/Outlook/Inbo" . ?k)
            )
          )

(require 'org-mu4e)
(setq org-mu4e-convert-to-html t)
(setq mu4e-view-prefer-html t)
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)


(defun mu4e-no-background()
  (interactive )
  (setq shr-use-colors t)
  (advice-add #'shr-colorize-region :around (defun shr-no-colourise-region (&rest ignore)))
  (setq shr-color-visible-luminance-min 60)
  (setq shr-color-visible-distance-min 5)
  )

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq org-latex-create-formula-image-program 'dvipng)

;; (use-package org-mime)
;; (setq org-mime-library 'mml)

(defun efs/ielm-send-line-or-region ()
  (interactive)
  (unless (use-region-p)
    (forward-line 0)
    (set-mark-command nil)
    (forward-line 1))
  (backward-char 1)
  (let ((text (buffer-substring-no-properties (region-beginning)
                                              (region-end))))
    (with-current-buffer "*ielm*"
      (insert text)
      (ielm-send-input))

    (deactivate-mark)))

(defun efs/show-ielm ()
  (interactive)
  (select-window (split-window-vertically -10))
  (ielm)
  (text-scale-set 1))

(define-key org-mode-map (kbd "C-c e") 'efs/ielm-send-line-or-region)
(define-key org-mode-map (kbd "C-c E") 'efs/show-ielm)

(use-package pdf-tools
  :ensure t
  :config)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package counsel
:ensure t
:bind
(("M-y" . counsel-yank-pop)
 :map ivy-minibuffer-map
 ("M-y" . ivy-next-line)))

(use-package ivy
:ensure t
:diminish (ivy-mode)
:bind (("C-x b" . ivy-switch-buffer))
:config
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "%d/%d ")
(setq ivy-display-style 'fancy))

(use-package swiper
:ensure t
:bind (("C-s" . swiper-isearch)
       ("C-c C-r" . ivy-resume)
       ("M-x" . counsel-M-x)
       ("C-x C-f" . counsel-find-file))
:config
(progn
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  ))

;; (use-package autopair
;; :config (autopair-global-mode))

(use-package avy
:ensure t
:bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs

(use-package auto-complete
:ensure t
:init
(progn
(ac-config-default)
  (global-auto-complete-mode t)
 ))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

(use-package auto-yasnippet
:ensure t)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package general
    :ensure t
    :config)
(general-define-key 
 "C-M-j" 'counsel-switch-buffer)

(use-package command-log-mode)
(global-command-log-mode t)

;; (require 'eaf)
  ;; (use-package eaf
  ;;   :load-path "~/.emacs.d/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  ;;   :custom
  ;;   (eaf-find-alternate-file-in-dired t)
  ;;   :config
  ;;   (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  ;;   (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  ;;   (eaf-bind-key take_photo "p" eaf-camera-keybinding))

;; (defun efs/exwm-update-class ()
;;   (exwm-workspace-rename-buffer exwm-class-name))

;; (use-package exwm
;;   :config
;;   ;; Set the default number of workspaces
;;   (setq exwm-workspace-number 5)

;;   ;; When window "class" updates, use it to set the buffer name
;;   ;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

;;   ;; These keys should always pass through to Emacs
;;   (setq exwm-input-prefix-keys
;;     '(?\C-x
;;       ?\C-u
;;       ?\C-h
;;       ?\M-x
;;       ?\M-`
;;       ?\M-&
;;       ?\M-:
;;       ?\C-\M-j  ;; Buffer list
;;       ?\C-\ ))  ;; Ctrl+Space

;;   ;; Ctrl+Q will enable the next key to be sent directly
;;   (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;;   ;; Set up global key bindings.  These always work, no matter the input state!
;;   ;; Keep in mind that changing this list after EXWM initializes has no effect.
;;   (setq exwm-input-global-keys
;;         `(
;;           ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
;;           ([?\s-r] . exwm-reset)

;;           ;; Move between windows
;;           ([s-left] . windmove-left)
;;           ([s-right] . windmove-right)
;;           ([s-up] . windmove-up)
;;           ([s-down] . windmove-down)

;;           ;; Launch applications via shell command
;;           ([?\s-&] . (lambda (command)
;;                        (interactive (list (read-shell-command "$ ")))
;;                        (start-process-shell-command command nil command)))

;;           ;; Switch workspace
;;           ([?\s-w] . exwm-workspace-switch)

;;           ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
;;           ,@(mapcar (lambda (i)
;;                       `(,(kbd (format "s-%d" i)) .
;;                         (lambda ()
;;                           (interactive)
;;                           (exwm-workspace-switch-create ,i))))
;;                     (number-sequence 0 9))))

;;   (exwm-enable))

(use-package impatient-mode
:ensure t
:config )
(require 'impatient-mode)

;; projectile
(use-package projectile
  :ensure t
  :bind ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

;;(global-set-key (kbd "C-c C-f") 'fold-this-all)
(global-set-key (kbd "C-M-f") 'fold-this)
;;(global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)

(use-package helm
  :ensure t
  :config )

  (helm-mode 1)
  (require 'helm-config)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;  (global-set-key (kbd "C-x C-f") 'helm-find-files)

(use-package magit
:ensure
:bind (("C-x g" . magit-status)))

(global-set-key "\C-\M-l" 'latex-math-preview-insert-mathematical-symbol)
;; bigger latex fragment: put this into the init.el, otherweise this will not be executed
(plist-put org-format-latex-options :scale 3.0)

(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(setq org-latex-create-formula-image-program 'dvipng)

(use-package tex
  :ensure auctex)

(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

(setq org-latex-compiler "xelatex")
;;enable cdlatex
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))))

(use-package json-mode)

(use-package grip-mode
:ensure t
:config)

(use-package markdown-mode
    :ensure t
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "multimarkdown"))

;; (global-set-key (kbd "C-c z") 'kid-sdcv-to-buffer)
;; (defun kid-sdcv-to-buffer ()
;;   (interactive)
;;   (let ((word (if mark-active
;;                   (buffer-substring-no-properties (region-beginning) (region-end))
;;                   (current-word nil t))))
;;     (setq word (read-string (format "Search the dictionary for (default %s): " word)
;;                             nil nil word))
;;     (set-buffer (get-buffer-create "*sdcv*"))
;;     (buffer-disable-undo)
;;     (erase-buffer)
;;     (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n" word)))
;;       (set-process-sentinel
;;        process
;;        (lambda (process signal)
;;          (when (memq (process-status process) '(exit signal))
;;            (unless (string= (buffer-name) "*sdcv*")
;;              (setq kid-sdcv-window-configuration (current-window-configuration))
;;              (switch-to-buffer-other-window "*sdcv*")
;;              (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
;;              (local-set-key (kbd "q") (lambda ()
;;                                         (interactive)
;;                                         (bury-buffer)
;;                                         (unless (null (cdr (window-list))) ; only one window
;;                                           (delete-window)))))
;;            (goto-char (point-min))))))))

(defun now ()
(interactive)
( insert (current-time-string)))

(use-package ob-html-chrome
:ensure t
:config)

  (require 'ob-html-chrome)
  (setq org-confirm-babel-evaluate
        (lambda (lang body)
          (not (string= lang "html-chrome"))))

  (setq org-babel-html-chrome-chrome-executable
        "/usr/bin/google-chrome")

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode t))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package autoinsert
  :ensure t
  :config
  (setq auto-insert-query nil)
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode t))

;; (use-package org
   ;;   :ensure t
   ;;   :pin org)
   (use-package org-bullets
     :ensure t
     :config
     (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

   (custom-set-variables
    ;;  (customize-set-variables
    '(org-directory "~/Dropbox")
    '(org-default-notes-file (concat org-directory "/Note.org"))
    '(org-export-html-postamble nil)
    '(org-hide-leading-stars t)
    '(org-startup-folded (quote overview))
    '(org-startup-indented t)
    '(org-confirm-babel-evaluate nil)
    '(org-src-fontify-natively t)
    )


 ;;hide the emphasis markup (e.g. /.../ for italics, *...* for bold)
 (setq org-hide-emphasis-markers t)

  (use-package org-bullets
   :config
   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (let* ((variable-tuple
;;          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
;;                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;                ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;         (base-font-color     (face-foreground 'default nil 'default))
;;         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

;;    (custom-theme-set-faces
;;     'user
;;     `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-4 ((t (,@headline ,@variable-tuple :height 0.6))))
;;     `(org-level-3 ((t (,@headline ,@variable-tuple :height 0.7))))
;;     `(org-level-2 ((t (,@headline ,@variable-tuple :height 0.8))))
;;     `(org-level-1 ((t (,@headline ,@variable-tuple :height 0.9))))
;;     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))


(custom-theme-set-faces
  'user
  '(org-block ((t (:inherit fixed-pitch))))
  '(org-code ((t (:inherit (shadow fixed-pitch)))))
  '(org-document-info ((t (:foreground "dark orange"))))
  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
  '(org-link ((t (:foreground "royal blue" :underline t))))
  '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  '(org-property-value ((t (:inherit fixed-pitch))) t)
  '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
  '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
  '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(use-package htmlize :ensure t)
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
;;sure to enable software ditaa to work

(setq org-todo-keywords
      '((type  "Work(w)" "Study(s)" "forFun(f)" "|")
        (sequence  "TODO(t!)"  "|" "DONE(d!)")
        ))

(setq org-todo-keyword-faces
      '(
        ("Work" .       (:foreground "white" :weight bold))
        ("Study" .      (:foreground "yellow" :weight bold))
        ("forFun" .     (:foreground "red" :weight bold))
        ("DONE" .       (:foreground "green" :weight bold))
        ))

(global-set-key "\C-ca" 'org-agenda)
 (setq org-agenda-start-on-weekday nil)
 (setq org-agenda-custom-commands
       '(("c" "Simple agenda view"
          ((agenda "")
           (alltodo "")))))

 (global-set-key (kbd "C-c c") 'org-capture)

 (setq org-agenda-files (list 
                         "~/Dropbox/Note/Appointment.org"
                         ))

(setq org-capture-templates
'(
  ;; ("a" "Appointment" entry (file+headline "~/Dropbox/Note/Appointment.org"     "Appointment")  "* %u %? " :prepend t)
  ;;("n" "TagsNote"    entry (file+headline "~/Dropbox/Note/Note.org.gpg"        "TagsNote")     "* %u %? " :prepend t)
  ("n" "TagsNote"    entry (file+headline "~/Dropbox/Note/Appointment.org"        "TagsNote")     "* %u %? " :prepend t)
;; ("m" "Math"          entry (file+headline "~/Dropbox/Sprache/Math/Math.org"           "Math")  "* %u %? " :prepend t)
;; ("p" "Physik"        entry (file+headline "~/Dropbox/Sprache/Physik/Physik.org"      "Physik")  "* %u %? " :prepend t)
;; ("r" "ROS"           entry (file+headline "~/Dropbox/Sprache/ROS/ROS.org"               "ROS")  "* %u %? " :prepend t)
;; ("i" "Inf"           entry (file+headline "~/Dropbox/Sprache/Inf/Inf.org"               "Inf")  "* %u %? " :prepend t)
))
(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
(use-package noflet
  :ensure t )
(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    (org-capture)))
    ;; (require 'ox-beamer)
    ;; for inserting inactive dates
    (define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

(require 'epa-file)
(setq epa-file-select-key 0)
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key nil)

;; (use-package org-roam
;;   :ensure t
;;   :hook
;;   (after-init . org-roam-mode)
;;   :custom
;;   (org-roam-directory "~/Dropbox/subjects/")
;;   :bind (:map org-roam-mode-map
;;               (("C-c n l" . org-roam)
;;                ("C-c n f" . org-roam-find-file)
;;                ("C-c n g" . org-roam-graph))
;;               :map org-mode-map
;;               (("C-c n i" . org-roam-insert))
;;               (("C-c n I" . org-roam-insert-immediate))))

;; (add-hook 'after-init-hook 'org-roam-mode)

;; (use-package org-roam-server
;;   :ensure t
;;   :config
;;   (setq org-roam-server-host "127.0.0.1"
;;         org-roam-server-port 9090
;;         org-roam-server-export-inline-images t
;;         org-roam-server-authenticate nil
;;         org-roam-server-label-truncate t
;;         org-roam-server-label-truncate-length 60
;;         org-roam-server-label-wrap-length 20))
;;   (org-roam-server-mode)

;; (setq org-roam-completion-system 'helm)
;; (setq org-roam-buffer-width 0.2)

;; (defun my/org-roam--backlinks-list-with-content (file)
;;   (with-temp-buffer
;;     (if-let* ((backlinks (org-roam--get-backlinks file))
;;               (grouped-backlinks (--group-by (nth 0 it) backlinks)))
;;         (progn
;;           (insert (format "\n\n* %d Backlinks\n"
;;                           (length backlinks)))
;;           (dolist (group grouped-backlinks)
;;             (let ((file-from (car group))
;;                   (bls (cdr group)))
;;               (insert (format "** [[file:%s][%s]]\n"
;;                               file-from
;;                               (org-roam--get-title-or-slug file-from)))
;;               (dolist (backlink bls)
;;                 (pcase-let ((`(,file-from _ ,props) backlink))
;;                   (insert (s-trim (s-replace "\n" " " (plist-get props :content))))
;;                   (insert "\n\n")))))))
;;     (buffer-string)))

;; (defun my/org-export-preprocessor (backend)
;;   (let ((links (my/org-roam--backlinks-list-with-content (buffer-file-name))))
;;     (unless (string= links "")
;;       (save-excursion
;;         (goto-char (point-max))
;;         (insert (concat "\n* Backlinks\n") links)))))

;; (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)

(use-package helm-org-rifle
:ensure t
:config)	    	    
  (require 'helm-org-rifle)

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

(use-package org-noter
  :ensure t
  :config)

;; (defun my-beamer-bold (contents backend info)
;;   (when (eq backend 'beamer)
;;     (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

;; (add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)

;; (defun my-beamer-structure (contents backend info)
;;   (when (eq backend 'beamer)
;;     (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\structure" contents)))

;; (add-to-list 'org-export-filter-strike-through-functions 'my-beamer-structure)

(setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (ipython . t)
     (emacs-lisp . t)
     (java . t)
     (shell . t)
     (sql . t)
     (C . t)
     (js . t)
     (ditaa . t)
     (haskell . t)
     (dot . t)
     (org . t)
     (latex . t )
     (typescript . t)
     ))

(with-eval-after-load 'org)

;; (nconc org-babel-default-header-args:java
;;        '((:dir . nil)
;;          (:results . value)))

(use-package ob-ipython)
(use-package ein)

(use-package atomic-chrome
:ensure t
:config
(atomic-chrome-start-server))

(setq atomic-chrome-buffer-open-style 'frame)
