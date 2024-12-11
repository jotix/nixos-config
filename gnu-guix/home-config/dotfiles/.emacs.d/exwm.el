;;(use-package dmenu)

;;(use-package bluetooth)

;;(use-package pinentry
  ;; :ensure t
  ;; :config
(pinentry-start)

(defun jtx/lower-volume ()
  (interactive)
  (shell-command "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"))

(defun jtx/raise-volume ()
  (interactive)
  (shell-command "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))

(defun jtx/mute-volume ()
  (interactive)
  (shell-command "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

(use-package exwm
  :config
  
  ;; Set the initial workspace number.
  (unless (get 'exwm-workspace-number 'saved-value)
    (setq exwm-workspace-number 4))

  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
	    (lambda ()
	      (exwm-workspace-rename-buffer exwm-class-name)))

  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

    ;; These keys should always pass through to Emacs
  (setq exwm-input-prefix-keys
    '(?\C-x
      ?\C-z
      ?\C-u
      ?\C-h
      ?\M-x
      ?\M-`
      ?\M-&
      ?\M-:
      ?\C-\M-j  ;; Buffer list
      ?\C-\ ))  ;; Ctrl+Space

  (setq exwm-input-global-keys
	`((,(kbd "s-r") . exwm-reset)
	  (,(kbd "s-w") . exwm-workspace-switch)
	  (,(kbd "C-z d") . dmenu)
	  (,(kbd "<XF86AudioLowerVolume>") . jtx/lower-volume)
	  (,(kbd "<XF86AudioRaiseVolume>") . jtx/raise-volume)
	  (,(kbd "<XF86AudioMute>") . jtx/mute-volume)
	  (,(kbd "C-z b") . bluetooth-list-devices)
	  ([s-left] . windmove-left)
          ([s-right] . windmove-right)
          ([s-up] . windmove-up)
          ([s-down] . windmove-down))))

(exwm-enable)
