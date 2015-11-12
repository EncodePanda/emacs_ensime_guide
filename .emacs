;; the repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade.ferrier.me.uk/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; mandatory modules installation

(defun package-conditional-install (package-name)
  "Installs a package if it is not present"
  (unless (package-installed-p package-name)
  (package-refresh-contents) (package-install package-name)))

(defun packages-conditional-install (packages)
  ""
  (when packages
    (package-conditional-install (car packages))
    (packages-conditional-install (cdr packages))))

(packages-conditional-install
 '(ensime scala-mode2 magit git-gutter neotree zoom-frm ace-window avy csv-mode
   elmacro key-chord multiple-cursors annoying-arrows-mode restclient smartparens
))

(when (not package-archive-contents)
  (package-refresh-contents))

;; ensime hooked to scala-mode
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("51e228ffd6c4fff9b5168b31d5927c27734e82ec61f414970fc6bcce23bc140d" "c9e123d4ecd9ceb056806c6297336763e9e96eed6962bfc1d5252afcc2761610" default)))
 '(safe-local-variable-values (quote ((python-shell-interpreter . "python3")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; missing tools
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  (next-line))

(defun copy-line (arg)
    "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
    (interactive "p")
    (let ((beg (line-beginning-position))
          (end (line-end-position arg)))
      (when mark-active
        (if (> (point) (mark))
            (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
          (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
      (if (eq last-command 'copy-line)
          (kill-append (buffer-substring beg end) (< end beg))
        (kill-ring-save beg end)))
    (kill-append "\n" nil)
    (beginning-of-line (or (and arg (1+ arg)) 2))
    (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(defun double-line (arg)
  "copy line and place it below the original"
  (interactive "p")
  (copy-line arg)
  (yank)
  (move-end-of-line))

;; additional shortkey
(global-set-key (kbd "C-s-c C-s-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x G") 'magit-status)
(global-set-key (kbd "C-x R") 'magit-ediff-resolve)
(global-set-key (kbd "C-c /") 'toggle-comment-on-line)
(global-set-key (kbd "C-c d") 'double-line)
(global-set-key (kbd "C-+") 'zoom-frm-in)
(global-set-key (kbd "C-_") 'zoom-frm-out)
(global-set-key (kbd "C-c C-v V") 'find-name-dired)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-c C-f g") 'find-grep)
(global-set-key (kbd "C-c j") 'avy-goto-subword-1)
(global-set-key (kbd "C-c \\") 'ace-window)
(global-set-key (kbd "C-c C-s s") 'ace-swap-window)
(global-set-key (kbd "C-c C-s m") 'ace-maximize-window)

(key-chord-mode 1)

(key-chord-define-global "sw" 'ace-swap-window)

;; remember all opened files
(desktop-save-mode 1)

;; enable mandatory modes
(global-git-gutter-mode +1)

(custom-set-variables
 '(git-gutter:update-interval 2))


(show-paren-mode 1)
(column-number-mode 1)

;; disable gui-related nonsens
(tool-bar-mode 0)
(menu-bar-mode 0)

;; prompt only y or no
(fset `yes-or-no-p `y-or-n-p)

(setq haskell-mode-hook (quote (turn-on-haskell-indentation)))


(annoying-arrows-mode 1)

(elmacro-mode 1)


;; ignore first test
(defun ignore-fst-test ()
  "Change me!"
  (interactive)
  (beginning-of-buffer nil)
  (isearch-forward nil 1)
  (isearch-printing-char 116 1)
  (isearch-printing-char 101 1)
  (isearch-printing-char 115 1)
  (isearch-printing-char 116 1)
  (isearch-printing-char 40 1)
  (isearch-printing-char 34 1)
  (isearch-exit)
  (forward-word 1)
  (backward-word 1)
  (backward-word 1)
  (delete-forward-char 1 nil)
  (delete-forward-char 1 nil)
  (delete-forward-char 1 nil)
  (delete-forward-char 1 nil)
  (insert "ignore"))

(key-chord-define-global "it" 'ignore-fst-test)
