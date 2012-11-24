;;; XEmacs backwards compatibility file
  (setq user-init-file
        (expand-file-name "init.el"
  			(expand-file-name ".emacs-my" "~")))
(setq custom-file
      (expand-file-name "custom.el"
			(expand-file-name ".emacs-my" "~")))

(setq vlog-mode 
      (expand-file-name "verilog-mode.el"
                        (expand-file-name ".emacs-my" "~")))

(setq xcscope-file 
      (expand-file-name "xcscope.el"
                        (expand-file-name ".emacs-my" "~")))

(load-file user-init-file)
(load-file custom-file)
(load-file vlog-mode)    
(load-file xcscope-file)

;; Indentation configuration
(setq c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(defun my-c++-mode-default-setup ()
  (c-set-style "cc-mode"))
(add-hook 'c++-mode-hook 'my-c++-mode-default-setup)

;for Makefiles
(defun my-makefile-default-setup ()
 (setq indent-tabs-mode t))
(add-hook 'makefile-mode-hook 'my-makefile-indent-setup)    

;; Treat .h files as C++ files
(setq auto-mode-alist
 (append '(("\\.h\\'" . c++-mode))
  auto-mode-alist))

;; Treat .inl (C++ inline) files as C++ files
(setq auto-mode-alist
 (append '(("\\.inl\\'" . c++-mode))
  auto-mode-alist))

(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(setq auto-mode-alist 
  (cons  '("\\.v\\'" . verilog-mode) 
     auto-mode-alist))
(setq auto-mode-alist 
   (cons  '("\\.pgv\\'" . verilog-mode) 
      auto-mode-alist))

;; treating upf and cpf files as tcl
(setq auto-mode-alist
    (append '(("\\.upf\\'" . tcl-mode))
        auto-mode-alist))
(setq auto-mode-alist
    (append '(("\\.cpf\\'" . tcl-mode))
        auto-mode-alist))

;; Frame title == "emacs: <buffer name>"
(setq frame-title-format "emacs : %b")

;; '%' key show the matching parenthesis, like in vi
(global-set-key "%" 'match-paren)
(defun match-paren (arg) 
   " Go to the matching parenthesis if on parenthesis otherwise inset %."
   (interactive "p")  
   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
         ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
         (t (self-insert-command (or arg 1)))))

;; cc-mode for C/C++ files
(require 'cc-mode)

;; c/C++ style
;;(c-set-style "cc-mode")

;; cscope 
(require 'xcscope)

;; Invoke 'compile' with these key-stroke
(global-set-key '[(control c) (o)] 'compile)

;; Goto line  
(global-set-key '[(control l)] 'goto-line)

;; Highlighting select
(setq zmacs-regions t)


;; to copy lines
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(global-set-key '[(control c) (c)] 'copy-line)


;; Background color
(set-background-color        "gray80")

;; Retain the mouse highlight
(setq mouse-sel-retain-highlight t)

;; turn off the toolbar
(if (>= emacs-major-version 21)
    (tool-bar-mode -1))

;; turn off the scrollbar
(scroll-bar-mode -1)

;; turn off the menubar
(menu-bar-mode -1)


;; turn on word wrapping in text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; turn off backing up of files
(setq make-backup-files nil)
(setq backup-inhibited t)

;; scroll by mouse wheel
(mouse-wheel-mode t)

;; DEL should erase character under the cursor
(setq normal-erase-is-backspace t)

;; Inhibit startup-message
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)


;; Which function mode
(setq-default which-func-mode t)

;; For easier navigation between the windows using M-up, M-down, M-left and M-right keys
;;(windmove-default-keybindings 'meta)

;; load cedet (Collection of Emacs Development Environment Tools)
(load-file "~/.emacs-my/cedet.el")
(global-ede-mode 1)
(semantic-load-enable-code-helpers)


;; ecb (Emacs Code Browser) settings
(add-to-list 'load-path
             "~/.emacs-my/ecb/ecb-2.40")
(load-file "~/.emacs-my/ecb/ecb-2.40/ecb.el")
(require 'ecb-autoloads)


;; color themes
(add-to-list 'load-path "~/.emacs-my/color-theme/color-theme-6.6.0")
(load-file "~/.emacs-my/color-theme/color-theme-6.6.0/color-theme-autoloads.elc")
;(require 'color-theme-autoloads)
;(color-theme-robin-hood)


;; haskell mode
(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


;; slime (Superior Lisp Interaction Mode in Emacs)
(add-to-list 'load-path "~/.emacs-my/slime")
(setq inferior-lisp-program "/usr/bin/clisp -K base")
(setq common-lisp-hyperspec-root "file:/home/suman/Downloads/CL-hyperspec/HyperSpec/")
(require 'slime)
(slime-setup '(slime-fancy))


;; w3m
(add-to-list 'load-path "~/.emacs-my/emacs-w3m-1.4.4")
(require 'w3m-load)
(require 'w3m)


;; ido mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; icicles mode
;; (add-to-list 'load-path "~/.emacs-my/icicles/icicles")
;; (require 'icicles)

;; Ruby debug (rdebug)
(add-to-list 'load-path "~/.emacs-my/rdebug")
(require 'rdebug)


;; pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (eval-after-load "pymacs"
;;   '(add-to-list 'pymacs-load-path "~/.emacs-my/pymacs/pinard-Pymacs-016b0bc"))

;; rope
(add-to-list 'load-path "~/.emacs-my/pymacs/pinard-Pymacs-016b0bc")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; auto complete
(add-to-list 'load-path "~/.emacs-my/auto-complete-1.2")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs-my/auto-complete-1.2/dict")
(ac-config-default)


;; yasnippet
(add-to-list 'load-path "~/.emacs-my/yasnippet/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle

(yas/initialize)
(yas/load-directory "~/.emacs-my/yasnippet/yasnippet-0.6.1c/snippets")


;; Magit
(require 'magit)

;; eassist
(require 'eassist)
(local-set-key "\C-ce" 'eassist-list-methods)

;; php-mode
(add-to-list 'load-path "~/.emacs-my/php-mode/php-mode-1.5.0")
(require 'php-mode)


;; espresso-mode for javascript
(add-to-list 'load-path "~/.emacs-my/espresso")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))


;; ruby-mode
(add-to-list 'load-path "~/.emacs-my/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; yari - Yet Another RI mode
(load-file "~/.emacs-my/ruby-mode/yari.el")
(defun ri-bind-key ()
  (local-set-key [f1] 'yari))
(add-hook 'ruby-mode-hook 'ri-bind-key)

;; rinari -- ruby on rails development in emacs
(add-to-list 'load-path "~/.emacs-my/rinari")
(add-to-list 'load-path "~/.emacs-my/rinari/util")
(add-to-list 'load-path "~/.emacs-my/rinari/util/inf-ruby")
(add-to-list 'load-path "~/.emacs-my/rinari/util/jump")
(require 'rinari)
(load-file "~/.emacs-my/rinari/rinari-keybindings.el")

;; rspec-mode 
(add-to-list 'load-path "~/.emacs-my/ruby-mode/rspec-mode")
(require 'rspec-mode)

;; xml-mode -- needed for nxhtml-mode
(add-to-list 'load-path "~/.emacs-my/nxml-mode")
(load "~/.emacs-my/nXhtml/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.erb$" . eruby-nxhtml-mumamo-mode))


;; coffee-script mode
(add-to-list 'load-path "~/.emacs-my/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

