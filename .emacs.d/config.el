
(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-zsh)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<s-return>") 'ansi-term)

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/img/ayylmao.png")
  (setq dashboard-items '((recents  . 10)
                          (projects . 5)))
  (setq dashboard-banner-logo-title "Ayy lmao"))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq spaceline-buffer-encoding-abbrev-p nil)
  (setq spaceline-line-column-p nil)
  (setq spaceline-line-p nil)
  (setq default-powerline-separator (quote arrow))
  (spaceline-emacs-theme))

(setq powerline-default-separator nil)

(display-time-mode 1)

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %d %B %Y")

(use-package fancy-battery
  :ensure t
  :config
  (setq fancy-battery-show-percentage t)
  (setq battery-update-interval 15)
  (if window-system
    (fancy-battery-mode)
    (display-battery-mode)))

(use-package projectile
  :ensure t
  :init (projectile-mode 1))

;; let projectile call make, I guess?
(global-set-key (kbd "<F5>") 'projectile-compile-project)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(when window-system (global-hl-line-mode t))

(when window-system
  (use-package pretty-mode
    :ensure t
    :config
    (global-pretty-mode t)))

(use-package unicode-fonts
  :ensure t
  :config
  (unicode-fonts-setup))

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq inhibit-startup-message t)

(global-subword-mode 1)

(setq electric-pair-pairs '(
                            (?\( . ?\))
                            (?\[ . ?\])
                            ))

(electric-pair-mode t)

(line-number-mode 1)
(column-number-mode 1)

(use-package linum-relative
  :ensure t
  :config
  (setq linum-relative-current-symbol "")
  (add-hook 'prog-mode-hook 'linum-relative-mode))

(use-package mark-multiple
  :ensure t
  :bind ("C-c q" . 'mark-next-like-this))

(use-package expand-region
  :ensure t
  :bind ( "C-q" . er/expand-region))

(use-package async
  :ensure t
  :init (dired-async-mode 1))

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq org-ellipsis " ")
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-export-with-smart-quotes t)
(setq org-src-window-setup 'current-window)
(add-hook 'org-mode-hook 'org-indent-mode)

(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(use-package htmlize
  :ensure t)

(use-package helm
  :ensure t
  :bind
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-b" . 'helm-buffers-list)
  ("M-x" . 'helm-M-x)
  :config
  (defun marko/helm-hide-minibuffer ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'marko/helm-hide-minibuffer)
  (setq helm-autoresize-max-height 0
        helm-autoresize-min-height 40
        helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-split-window-in-side-p nil
        helm-move-to-line-cycle-in-source nil
        helm-ff-search-library-in-sexp t
        helm-scroll-amount 8
        helm-echo-input-in-header-line t)
  :init
  (helm-mode 1))

(require 'helm-config)
(helm-autoresize-mode 1)
(define-key helm-find-files-map (kbd "C-b") 'helm-find-files-up-one-level)
(define-key helm-find-files-map (kbd "C-f") 'helm-execute-persistent-action)

(global-set-key (kbd "C-x b") 'ibuffer)

(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c i w") 'kill-whole-word)

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(defun copy-current-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-current-line)

(global-set-key (kbd "C-c k w l") 'kill-whole-line)

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-s-k") 'kill-all-buffers)

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package rainbow-mode
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts
        '("a" "s" "d" "f" "h" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

;; horizontal splits
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

;; vertical splits
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))
  
(global-set-key (kbd "C-c c") 'company-complete)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(unless (package-installed-p 'ac-php)
  (package-refresh-contents)
  (package-install 'ac-php))

(add-hook 'php-mode-hook 'company-mode)

(defun php-mode-company-init ()
  (ac-php-core-eldoc-setup) ;; enable eldoc
  (setq-local company-backends '((company-ac-php-backend))))

(use-package company-php
  :ensure t
  :config
  (require 'company)
  (add-hook 'php-mode-hook 'php-mode-company-init))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(add-hook 'emacs-lisp-mode-hook 'company-mode)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

(use-package slime-company
  :ensure t
  :init
  (require 'company)
  (slime-setup '(slime-fancy slime-company)))

(use-package rust-mode
  :ensure t)

(use-package racer
  :ensure t)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook
          '(lambda ()
             (require 'racer)
             (setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
             (setq racer-rust-src-path
                   (string-trim
                    (shell-command-to-string "echo `rustc --print sysroot`/lib/rustlib/src/rust/src")))
             (local-set-key (kbd "TAB") #'company-indent-or-complete-common)))

(use-package flycheck-rust
  :ensure t)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(defun keybind-rust-format-buffer ()
  (interactive)
  (local-set-key (kbd "C-c TAB") #'rust-format-buffer))

(add-hook 'rust-mode-hook 'keybind-rust-format-buffer)

(use-package cargo
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package toml-mode
  :ensure t
  :config
  (require 'toml-mode))

(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 80)
  :bind
  ("M-g" . magit-status))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (defin-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs (if (executable-find "python") 3 0)
          treemacs-file-event-delay 5000
          treemacs-follow-after-init t
          treemacs-follow-recenter-distance 0.1
          treemacs-goto-tag-strategy 'refetch-index
          treemacs-indentation 2
          treemacs-indentation-string " "
          treemacs-is-never-other-window nil
          treemacs-no-png-images nil
          treemacs-project-follow-cleanup nil
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow nil
          treemacs-show-hidden-files t
          treemacs-silent-filewatch nil
          treemacs-silent-refresh nil
          treemacs-sorting 'alphabetic-desc
          treemacs-tag-follow-cleanup t
          treemacs-tag-follow-delay 0
          treemacs-width 35)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0" . treemacs-select-window)
        ("C-x t 1" . treemacs-delete-other-windows)
        ("C-x t t" . treemacs)
        ("C-x t B" . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)
