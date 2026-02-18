;;; init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       (corfu +orderless)
       vertico

       :ui
       doom
       doom-dashboard
       hl-todo
       modeline
       neotree
       ophints
       (popup +defaults)
       (vc-gutter +pretty)
       vi-tilde-fringe
       workspaces

       :editor
       ;;(evil +everywhere)
       file-templates
       fold
       snippets

       :emacs
       dired
       electric
       calendar
       undo
       vc

       :term
       eshell

       :checkers
       syntax

       :tools
       (eval +overlay)
       lookup
       magit
       pdf
       lsp

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       emacs-lisp
       markdown
       org
       (python +lsp)
       sh

       :config
       (default +bindings +smartparens))