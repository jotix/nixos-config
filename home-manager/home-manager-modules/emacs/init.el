;; emacs config file location
(setq jtx-emacs-config-file "~/nixos-config/homeManagerModules/editors/emacs/init.el")

(defalias 'yes-or-no-p 'y-or-n-p)

(when window-system (global-hl-line-mode 0))
(global-hl-line-mode 0)

(when window-system (global-prettify-symbols-mode t))

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq electric-pair-pairs '(
			    (?\( . ?\))
			    (?\[ . ?\])
			    (?\{ . ?\})
			    (?\" . ?\")))
(electric-pair-mode t)

;; recent files
(recentf-mode 1)

;; history
(setq history-lenght 25)
(savehist-mode 1)

;; remember and restore the last cursor location
(save-place-mode 1)

;; move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; revert buffers when underlying file has changed
(global-auto-revert-mode 1)

;; revert dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; undo-history files location
(setq undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo")))

;; avoid confirmation for closinbg a buffer with a running process
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(setq indent-tabs-mode nil)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(edt-set-scroll-margins "20%" "25%")
(setq scroll-margin 8)

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(global-visual-line-mode t)

;; disable line numbers in some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		vterm-mode-hook
		dired-mode-hook))
  (add-hook mode #'(lambda () (display-line-numbers-mode 0))))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(display-time-mode)

;; set up the visible bell
(setq visible-bell t)

;; fix fullscreen don't cover all space
(setq frame-resize-pixelwise t)

(defun jtx/set-font-faces ()
  (set-face-attribute 'default nil
		      :font "Jetbrains Mono"
	 	      :height 105
		      :weight 'medium)

  (set-face-attribute 'font-lock-comment-face nil
		      :slant 'italic)

  (set-face-attribute 'font-lock-keyword-face nil
		      :slant 'italic))

(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(with-selected-frame frame
		  (jtx/set-font-faces))))
  (jtx/set-font-faces))


;; frame-size
(set-frame-size (selected-frame) 200 48)

;; packages config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; minibuffer (vertico, marginalia, consult & orderless)

(setq vertico-cycle t)
(setq vertico-resize nil)
(vertico-mode 1)

(marginalia-mode 1)

;;(use-package consult)

(setq completion-styles '(orderless basic))

;; multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; dashboard
(dashboard-setup-startup-hook)
(setq dashboard-display-icons-p t)
(setq dashboard-icon-type 'nerd-icons)

;; all-the-icons-dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; spacemacs-theme
(load-theme 'spacemacs-dark t)

;; spaceline
(spaceline-spacemacs-theme)

;; which-key
(which-key-mode 1)
(setq which-key-idle-delay 0.3)

;; hungry-delete
(global-hungry-delete-mode 1)

;; undo-tree
(global-undo-tree-mode 1)

;; eshell-git-prompt
(eshell-git-prompt-use-theme 'powerline)

;; company
(add-hook 'prog-mode-hook 'company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.0)

;; eglot
(add-hook 'prog-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(setq python-shell-completion-native-disabled-interpreters '("python"))

;; org
(setq org-ellipsis " ▾")
(add-hook 'org-mode-hook 'org-bullets-mode)
(add-hook 'org-mode-hook 'org-auto-tangle-mode)

;; org-tempo, for <s TAB use
(require 'org-tempo)
(setq org-structure-template-alist
      '(("el" . "src emacs-lisp")
	("py" . "src python")
	("hs" . "src haskell")
	("c" . "src conf")
	("s" . "src")))

;; org-present
(add-hook 'org-present-mode-hook 'jtx/org-present-start)
(add-hook 'org-present-mode-quit-hook 'jtx/org-present-end)
(add-hook 'org-present-after-navigate-functions 'jtx/org-present-prepare-slide)

;;open source edit in the same windows
(setq org-src-window-setup 'current-window)

;;Set faces for heading levels
(dolist (face '((org-level-1 . 1.3)
		(org-level-2 . 1.2)
		(org-level-3 . 1.1)
		(org-level-4 . 1.0)
		(org-level-5 . 1.0)
		(org-level-6 . 1.0)
		(org-level-7 . 1.0)
		(org-level-8 . 1.0)))
  (set-face-attribute (car face) nil :height (cdr face)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)))

(setq org-confirm-babel-evaluate nil)

;; toc-org
(add-hook 'org-mode-hook 'toc-org-mode)

;; disabling the anoying org automatic indentation
(electric-indent-mode 1)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)
(setq org-src-preserve-indentation nil)
(setq org-support-shift-select 1)

;; dired
;; Make dired open in the same window when using RET or ^
(require 'dired)
(put 'dired-find-alternate-file 'disabled nil) ; disables warning
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") #'(lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory

;; eshell
(add-hook 'eshell-mode-hook #'(lambda () (setenv "TERM" "xterm-256color")))
(setq shell-file-name "bash")

;; vterm
(defun jtx/vterm-hook ()
  (define-key vterm-mode-map "\C-z" nil))

(add-hook 'vterm-mode-hook 'jtx/vterm-hook)

;; slime
(setq inferior-lisp-program "sbcl")

;; ace-window
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-scope 'frame)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?j ?k ?l))
(setq aw-minibuffer-flag t)

;; Custom Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jtx/org-present-prepare-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)
  ;; Unfold the current entry
  (org-show-entry)
  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

(defun jtx/org-present-start ()
  ;; Tweak font sizes
  (setq-local face-remapping-alist
	      '((default (:height 1.6) fixed-pitch)
                (header-line (:height 4.0) variable-pitch)
                (org-document-title (:height 1.75) org-document-title)
                (org-code (:height 1.5) fixed-pitch)
                (org-verbatim (:height 1.5) fixed-pith)
                (org-block (:height 1.5) fixed-pith)
                (org-block-begin-line (:height 0.7) fixed-pitch)))
  (setq header-line-format " ")
  (setq visual-fill-column-width 160)
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun jtx/org-present-end ()
  (setq-local face-remapping-alist '((default default default)))
  (visual-fill-column-mode 0)
  (visual-line-mode 0))

(defun jtx/kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))

(defun jtx/kill-current-buffer-and-close-window ()
  (interactive)
  (kill-current-buffer)
  (delete-window))

(defun jtx/load-emacs-config-file ()
  (interactive)
  (find-file jtx-emacs-config-file))

(defun jtx/dired-dot ()
  (interactive)
  (dired "."))

(defun jtx/indent-region ()
  (interactive)
  (org-babel-mark-block)
  (indent-region (region-beginning) (region-end)))

(defun jtx/mark-block-and-send-to-elpy ()
  (interactive)
  (org-babel-mark-block)
  (elpy-shell-send-region-or-buffer)
  (elpy-shell-switch-to-shell)
  (end-of-buffer))

(defun jtx/enlarge-font ()
  (interactive)
  (text-scale-adjust +1))

(defun jtx/shrink-font ()
  (interactive)
  (text-scale-adjust -1))

(defun jtx/enlarge-all-fonts ()
  (interactive)
  (let ((old-face-attribute (face-attribute 'default :height)))
    (set-face-attribute 'default nil :height (+ old-face-attribute 20))))

(defun jtx/set-font-size-for-screen-sharing ()
  (interactive)
  (set-face-attribute 'default nil :height 140))

(defun jtx/set-font-size-normal ()
  (interactive)
  (set-face-attribute 'default nil :height 100))

(defun jtx/shrink-all-fonts ()
  (interactive)
  (let ((old-face-attribute (face-attribute 'default :height)))
    (set-face-attribute 'default nil :height (- old-face-attribute 20))))

(defun jtx/set-frame-size-normal ()
    (interactive)
    (set-frame-size (selected-frame) 230 60))

(defun jtx/set-frame-size-small ()
    (interactive)
    (set-frame-size (selected-frame) 144 36))

(defun jtx/save-marked-text-to-file (file)
  "Save the marked text to a file."
  (interactive "FEnter file name: ")
  (if (use-region-p)
      (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
        (with-temp-file file
          (insert text)))
    (message "No text is currently marked."))
  (deactivate-mark))

(defun jtx/python-execute-block-in-eshell ()
  (interactive)
  (org-babel-mark-block)
  (jtx/save-marked-text-to-file "~/.tmp/aux.py")
  (jtx/send-command-to-eshell "python3 ~/.tmp/aux.py"))

(defun jtx/send-command-to-eshell (command)
  "Send a command to the active Eshell buffer."
  (interactive "sEnter a command: ")
  (if (eq (get-buffer "*eshell*") nil)
      (eshell))
  (with-current-buffer "*eshell*"
    (eshell-return-to-prompt)
    (insert command)
    (eshell-send-input)
    (switch-to-buffer "*eshell*")))

(defun eshell-open-p ()
  "Check if an eshell buffer is open."
  (let ((eshell-buffer (get-buffer "*eshell*")))
    (when eshell-buffer
      (with-current-buffer eshell-buffer
        (eq major-mode 'eshell-mode)))))

;; keybindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-unset-key (kbd "C-z"))
(define-prefix-command 'jtx/prefix)
(global-set-key (kbd "C-z") 'jtx/prefix)
(global-set-key (kbd "C-z o") 'other-window)
(global-set-key (kbd "C-z c") 'jtx/load-emacs-config-file)
(global-set-key (kbd "C-z k") 'jtx/kill-current-buffer-and-close-window)
(global-set-key (kbd "C-z w") 'delete-other-windows)
(global-set-key (kbd "C-z q") 'delete-window)
(global-set-key (kbd "C-z h") 'split-window-right)
(global-set-key (kbd "C-z v") 'split-window-vertically)
(global-set-key (kbd "C-z /") 'comment-region)
(global-set-key (kbd "C-z C-/") 'uncomment-region)
(global-set-key (kbd "C-z m") 'magit)
(global-set-key (kbd "C-z RET") 'eshell)
(global-set-key (kbd "C-z t") 'vterm)
(global-set-key (kbd "C-z f") 'recentf-open-files)
(global-set-key (kbd "C-z r") 'treemacs)

(global-set-key (kbd "C-z z") 'jtx/set-font-size-for-screen-sharing)
(global-set-key (kbd "C-z n") 'jtx/set-font-size-normal)
(global-set-key (kbd "C->") 'jtx/enlarge-all-fonts)
(global-set-key (kbd "C-<") 'jtx/shrink-all-fonts)

;; (global-set-key (kbd "C-z z") 'jtx/set-frame-size-small)
;; (global-set-key (kbd "C-z n") 'jtx/set-frame-size-normal)

(define-key org-mode-map (kbd "C-c b m") 'org-babel-mark-block)
(define-key org-mode-map (kbd "C-c p") 'jtx/mark-block-and-send-to-elpy)
(define-key org-mode-map (kbd "C-c e") 'org-babel-execute-src-block)
(define-key org-mode-map (kbd "C-c y") 'jtx/python-execute-block-in-eshell)
(define-key org-mode-map (kbd "C-c p") 'org-present)

(require 'org-present)
(define-key org-present-mode-keymap (kbd "<left>") 'backward-char)
(define-key org-present-mode-keymap (kbd "<right>") 'right-char)
(define-key org-present-mode-keymap (kbd "C-<right>") 'org-present-next)
(define-key org-present-mode-keymap (kbd "C-<left>") 'org-present-prev)

(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-x C-b") 'consult-buffer)
(global-set-key (kbd "C-x d") #'(lambda () (interactive) (dired ".")))

(global-set-key (kbd "C-z C-e") 'hs-hide-block)
(global-set-key (kbd "C-z C-a") 'hs-show-block)

