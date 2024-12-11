;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (nongnu packages linux)
             (nongnu system linux-initrd)
	     (gnu packages admin)
	     (gnu packages package-management)
	     (gnu packages version-control)
	     (gnu packages compression)
             (guix channels))

(use-service-modules cups desktop networking ssh xorg virtualization)

(define my-channels
  (cons* (channel
          (name 'nonguix)
          (url "https://gitlab.com/nonguix/nonguix")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
         %default-channels))

(define %jtx/vial-udev-rules
  (udev-rule
   "99-vial.rules"
   (string-append
    "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\","
    "ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\","
    "GROUP=\"users\", TAG+=\"uaccess\", TAG+=\"udev-acl\"")))

(operating-system

 ;; non-guix
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
 (locale "en_US.utf8")
 (timezone "America/Argentina/Buenos_Aires")
 (keyboard-layout (keyboard-layout "us" "altgr-intl"))
 (host-name "jtx-guix")

 ;; Packages installed system-wide.  Users can also install packages
 ;; under their own account: use 'guix search KEYWORD' to search
 ;; for packages and 'guix install PACKAGE' to install a package.
 (packages (append (list
		    git
		    p7zip
		    (specification->package "emacs")
                    (specification->package "emacs-exwm")
                    (specification->package "emacs-desktop-environment"))
                   %base-packages))

 ;; Below is the list of system services.  To search for available
 ;; services, run 'guix system search KEYWORD' in a terminal.
 (services
  (cons* (service xfce-desktop-service-type)
         ;; To configure OpenSSH, pass an 'openssh-configuration'
         ;; record as a second argument to 'service' below.
         (service openssh-service-type)
	 (service bluetooth-service-type)
	 (service libvirt-service-type
		  (libvirt-configuration
		   (unix-sock-group "libvirt")
		   (unix-sock-rw-perms "0777")))
	 (service virtlog-service-type
		  (virtlog-configuration))
         (set-xorg-configuration
          (xorg-configuration (keyboard-layout keyboard-layout)))

	 ;; nonguix substitutes
	 (modify-services %desktop-services
			  (guix-service-type config =>
					     (guix-configuration
					      (inherit config)
					      (substitute-urls
					       (append (list "https://substitutes.nonguix.org")
						       %default-substitute-urls))
					      (authorized-keys
					       (append (list (local-file "./signing-key.pub"))
						       %default-authorized-guix-keys))

					      ;; add my-channels
					      (channels my-channels)
					      (guix (guix-for-channels my-channels))))
			  
			  (udev-service-type config =>
					     (udev-configuration
					      (inherit config)
					      (rules (list %jtx/vial-udev-rules)))))))
 
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))
              (keyboard-layout keyboard-layout)))

 
 ;; The list of user accounts ('root' is implicit).
 (users (cons* (user-account
                (name "jotix")
                (comment "Jotix")
                (group "users")
                (home-directory "/home/jotix")
                (supplementary-groups '("wheel" "netdev" "audio" "video" "libvirt")))
               %base-user-accounts))
 
 ;; (swap-devices (list (swap-space
 ;;                       (target (uuid
 ;;                                "ed3e0535-c860-4a3b-9566-2939928d71e5")))))

 ;; The list of file systems that get "mounted".  The unique
 ;; file system identifiers there ("UUIDs") can be obtained
 ;; by running 'blkid' in a terminal.
 (file-systems (cons* (file-system
                       (mount-point "/")
                       (device (file-system-label "guix"))
                       (type "btrfs")
		       (options "subvol=/guix/root"))
		      (file-system
		       (mount-point "/home")
		       (device (file-system-label "guix"))
		       (type "btrfs")
		       (options "subvol=/guix/home"))
		      (file-system
		       (mount-point "/boot/efi")
		       (device (file-system-label "GUIX-EFI"))
		       (type "vfat"))
		      %base-file-systems)))
