;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; Performance optimizations
(use-package! gcmh
  :config
  (gcmh-mode 1)
  (setq gcmh-high-cons-threshold 134217728))