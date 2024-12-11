(define-module (jtx/fonts)
  #:use-module (ice-9 regex)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system font)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages c)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gd)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages xorg))

(define-public font-powerline
  (package
    (name "font-powerline")
    (version "1.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/powerline/fonts")
                    (commit "e80e3eba9091dac0655a0a77472e10f53e754bb0")))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0n8yhc8y1vpiyza58d4fj5lyf03ncymrxc81a31crlbzlqvwwrqq"))))
    (build-system font-build-system)
    (home-page
     "https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation")
    (synopsis "Powerline fonts")
    (description
     "This package provides a collection of patched fonts for Powerline users.")
    (license (list license:silofl1.1 license:asl2.0 license:expat
                   license:bsd-3
                   (license:x11-style "http://dejavu-fonts.org/")))))
