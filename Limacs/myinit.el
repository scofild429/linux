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
  (find-file "~/Dropbox/linux/Limacs/myinit.org"))
(global-set-key (kbd "<f2>") 'open-my-init-org-file)

;;open .bashrc file with f3
(defun open-my-bash-file()
  (interactive)
  (find-file "~/.bashrc"))
(global-set-key (kbd "<f3>") 'open-my-bash-file)

;; trun off cl warning
(setq byte-compile-warnings '(cl-functions))

;; backup oder
(setq backup-directory-alist `(("." . "~/.emacs.d/backup")))
(setq backup-by-copying t)

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

(global-set-key "\C-o" 'compile)
(global-set-key (kbd "C-c C-.") 'org-mark-ring-goto)
(global-set-key (kbd "C-M-,") 'menu-bar-mode)

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

;; (require 'cnfonts)
;; ;;让 cnfonts 随着 Emacs 自动生效。
;;  (cnfonts-enable)
;; ;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;;  (cnfonts-set-spacemacs-fallback-fonts)
;; ( cnfonts-enable)

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
  (use-package eaf
    :load-path "~/.emacs.d/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
    :custom
    (eaf-find-alternate-file-in-dired t)
    :config
    (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
    (eaf-bind-key take_photo "p" eaf-camera-keybinding))

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
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(use-package magit
:ensure
:bind (("C-x g" . magit-status)))

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
(global-set-key "\C-z" 'latex-math-preview-insert-symbol)

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

(global-set-key (kbd "C-c z") 'kid-sdcv-to-buffer)
(defun kid-sdcv-to-buffer ()
  (interactive)
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
                  (current-word nil t))))
    (setq word (read-string (format "Search the dictionary for (default %s): " word)
                            nil nil word))
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv" "-n" word)))
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
             (local-set-key (kbd "q") (lambda ()
                                        (interactive)
                                        (bury-buffer)
                                        (unless (null (cdr (window-list))) ; only one window
                                          (delete-window)))))
           (goto-char (point-min))))))))

(require 'posframe)
(use-package sdcv)
(require 'sdcv)

(setq sdcv-say-word-p t)               ;say word after translation
(global-set-key (kbd "C-M-w") 'sdcv-search-input+)

;; (setq sdcv-dictionary-data-dir "startdict_dictionary_directory") ;setup directory of stardict dictionary

;; (setq sdcv-dictionary-simple-list    ;setup dictionary list for simple search
;;       '("懒虫简明英汉词典"
;;         "懒虫简明汉英词典"
;;         "KDic11万英汉词典"))

;; (setq sdcv-dictionary-complete-list     ;setup dictionary list for complete search
;;       '(
;;         "懒虫简明英汉词典"
;;         "英汉汉英专业词典"
;;         "XDICT英汉辞典"
;;         "stardict1.3英汉辞典"
;;         "WordNet"
;;         "XDICT汉英辞典"
;;         "Jargon"
;;         "懒虫简明汉英词典"
;;         "FOLDOC"
;;         "新世纪英汉科技大词典"
;;         "KDic11万英汉词典"
;;         "朗道汉英字典5.0"
;;         "CDICT5英汉辞典"
;;         "新世纪汉英科技大词典"
;;         "牛津英汉双解美化版"
;;         "21世纪双语科技词典"
;;         "quick_eng-zh_CN"
;;         ))

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

(use-package org
  :ensure t
  :pin org)
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
(custom-set-variables
 '(org-directory "~/Dropbox/Note/")
 '(org-default-notes-file (concat org-directory "/Note.org"))
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(org-confirm-babel-evaluate nil)
 '(org-src-fontify-natively t)
 )

;;(require 'cl-lib)

      (use-package htmlize :ensure t)
      (setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
      ;;sure to enable software ditaa to work

(setq org-todo-keywords
  '((type "Work(w!)" "Study(s!)" "forFun(f!)" "|")
    (sequence  "TODO(t!)"  "|" "DONE(d!)")
))

(setq org-todo-keyword-faces
  '(
  ("Work" .       (:foreground "white" :weight bold))
  ("Study" .      (:foreground "red" :weight bold))
  ("forFun" .     (:foreground "black" :weight bold))
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
                         "~/Dropbox/Note/Note.org"
                         ))

(setq org-capture-templates
'(("a" "Appointment" entry (file+headline "~/Dropbox/Note/Appointment.org"     "Appointment")  "* %u %? " :prepend t)
("m" "Math"          entry (file+headline "~/Dropbox/Sprache/Math/Math.org"           "Math")  "* %u %? " :prepend t)
("p" "Physik"        entry (file+headline "~/Dropbox/Sprache/Physik/Physik.org"      "Physik")  "* %u %? " :prepend t)
("r" "ROS"           entry (file+headline "~/Dropbox/Sprache/ROS/ROS.org"               "ROS")  "* %u %? " :prepend t)
("i" "Inf"           entry (file+headline "~/Dropbox/Sprache/Inf/Inf.org"               "Inf")  "* %u %? " :prepend t)
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

;; (use-package org-roam-server
;;   :ensure t)

;; (use-package org-roam-server
;;   :ensure t
;;   :config
;;   (setq org-roam-server-host "127.0.0.1"
;;         org-roam-server-port 8082
;;         org-roam-server-export-inline-images t
;;         org-roam-server-authenticate nil
;;         org-roam-server-label-truncate t
;;         org-roam-server-label-truncate-length 60
;;         org-roam-server-label-wrap-length 20))


;; (setq org-roam-directory "~/Dropbox/")
;; (add-hook 'after-init-hook 'org-roam-mode)
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
   ))

(with-eval-after-load 'org)

(use-package ob-ipython)
(use-package ein)

(use-package lsp-mode
  :ensure t
  :config )
(use-package lsp-ui
  :ensure t
  :config )
(use-package dap-mode
  :ensure t
  :config )

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

(use-package lsp-jedi
  :ensure t
  :config)

(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package cmake-ide
  :ensure t
  :config
  (cmake-ide-setup))

(use-package yasnippet-snippets
  :ensure t
  :config)

(use-package rtags
  :ensure t
  :config
  (rtags-enable-standard-keybindings)
 (setq rtags-autostart-diagnostics t)
 (rtags-diagnostics)
 (define-key c-mode-base-map (kbd "M-.")
   (function rtags-find-symbol-at-point))
 (define-key c-mode-base-map (kbd "M-,")
   (function rtags-find-references-at-point))
 )

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
    :mode ("\\.py\\'" . python-mode)
    ;;    :interpreter ("/usr/bin/python3.6" . python-mode)
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
;;        python-shell-interpreter-args "-i --simple-prompt")

  ;; (setq python-shell-interpreter "jupyter"
  ;;       python-shell-interpreter-args "console --simple-prompt")



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
:ensure ac-js2
:init
(progn
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
))

(use-package js2-refactor
:ensure t
:config
(progn
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.
(add-hook 'js2-mode-hook #'js2-refactor-mode)))
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

;;(use-package jade
;;:ensure t
;;)

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


      ;;;;;;;;;;;;;;
      ;web-mode
      ;;;;;;;;;;;;;;;
  (use-package web-mode
  :ensure t
:config)

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

;; (autoload 'html-fold-mode "html-fold" "Minor mode for hiding and revealing elements." t)
;; (add-hook 'html-mode-hook 'html-fold-mode)
