(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-refresh-contents)
(package-initialize)

(defvar my-pkgs
  '(; Basic functionality
    ace-jump-mode
    browse-kill-ring
    confluence
    dash
    flx-ido
    flycheck
    idle-highlight-mode
    ido-ubiquitous
    iy-go-to-char
    magit
    multiple-cursors
    mvn
    nyan-mode
    paredit
    password-store
    projectile
    puppet-mode
    rainbow-delimiters
    rainbow-mode
    s
    smex
    smart-mode-line
    switch-window
    undo-tree
    monokai-theme
    smooth-scrolling
)
  "A list of packages to install at launch.")

(load-theme 'monokai t)

(dolist (p my-pkgs)
  (when (not (package-installed-p p))
    (package-install p)))



(setq ring-bell-function 'ignore)

(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" (shell-command-to-string "echo -n $PATH"))

(setq backup-by-copying t)
(setq inhibit-startup-message t)

;; Goto-line short-cut key
(global-set-key "\C-x\C-j" 'goto-line)
 
(set-face-attribute 'default nil :family "Source Code Pro")

;;JavaScript
(setq js-indent-level 2)

;; Scroll using M-n and M-p
(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   4)) )
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 4)) )


(global-set-key (kbd "C-,") 'previous-multiframe-window)
(global-set-key (kbd "C-.") 'next-multiframe-window)

(tool-bar-mode 0)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("64581032564feda2b5f2cf389018b4b9906d98293d84d84142d90d7986032d33" default)))
 '(standard-indent 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 

(setq tab-stop-list (number-sequence 2 200 2))
(setq-default indent-tabs-mode nil)


;;(color-theme-initialize)



(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(setq make-backup-files nil)

(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(setq ns-pop-up-frames nil)


(defun xsteve-remove-control-M ()
  "Remove ^M at end of line in the whole buffer."
  (interactive)
  (save-match-data
    (save-excursion
      (let ((remove-count 0))
        (goto-char (point-min))
        (while (re-search-forward (concat (char-to-string 13) "$") (point-max) t)
          (setq remove-count (+ remove-count 1))
          (replace-match "" nil nil))
        (message (format "%d ^M removed from buffer." remove-count))))))
