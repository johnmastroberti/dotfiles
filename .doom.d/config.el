;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Mastroberti"
      user-mail-address "johnmastroberti123@gmail.com")

; Don't ask to quit
(setq! confirm-kill-emacs nil)

; Disable "smart" parens
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

; LaTeX settings
; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-auto-private "~/.doom.d/auctex")
(setq font-latex-fontify-script nil)
(setq LaTeX-indent-environment-check nil)
(setq TeX-electric-sub-and-superscript nil)
; (setq-default Tex-master nil) ; useful for multi-file documents
(setq +latex-viewers '(zathura))
; Cleanup LaTeX build files after killing a .tex buffer
(defun jm/texclear ()
  (when (and buffer-file-name (string-match ".*\.tex" (buffer-file-name)))
    (message (concat "[JM] Running texclear on " (buffer-file-name)))
    (shell-command (concat "texclear " (buffer-file-name)))
    ))

(add-hook 'kill-buffer-hook 'jm/texclear)

; org settings
(after! org (setq org-format-latex-options (plist-put org-format-latex-options :scale 3)))


; LSP settings
; General mappings
(setq! lsp-ui-imenu-auto-refresh t)
(map! :desc "Open LSP imenu" :n "<f8>" #'lsp-ui-imenu)
; C++ lsp (clangd)
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

; Open Geant4 .mac files in sh-mode (close enough)
(add-to-list 'auto-mode-alist '("\\.mac\\'" . sh-mode))

; Auto close compilation window if successful
(setq compilation-finish-functions
      (lambda (buf str)
        (if (null (string-match ".*exited abnormally.*" str))
            ;;no errors, make the compilation window go away in a few seconds
            (progn
              (run-at-time
               "2 sec" nil 'delete-windows-on buf)
              (message "No Compilation Errors!")))))

; Open alternate file
(evil-ex-define-cmd "A" 'ff-find-other-file)

; Open output file
(defun open-output ()
  "Opens the corresponding output file for the current buffer"
  (shell-command (concat "opout " (buffer-file-name)))
)

(map! :leader :desc "Open output file" :n "o f"
      #'(lambda () (interactive)
          (shell-command (concat "opout " (buffer-file-name))))
      )

; Map :W and :Q to :w and :q
(evil-ex-define-cmd "W" 'evil-write)
(evil-ex-define-cmd "Q" 'evil-quit)


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 20 :weight 'semi-light))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Indent settings
(defun my-setup-indent (n)
  ;; java/c/c++
  (setq-local c-basic-offset n)
  ;; web development
  (setq-local coffee-tab-width n) ; coffeescript
  (setq-local javascript-indent-level n) ; javascript-mode
  (setq-local js-indent-level n) ; js-mode
  ;(setq-local js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq-local web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq-local web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq-local web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq-local css-indent-offset n) ; css-mode
  )

(defun my-office-code-style ()
  (interactive)
  (message "Office code style!")
  ;; use tab instead of space
  (setq-local indent-tabs-mode t)
  ;; indent 4 spaces width
  (my-setup-indent 4))

(defun my-personal-code-style ()
  (interactive)
  (message "My personal code style!")
  ;; use space instead of tab
  (setq indent-tabs-mode nil)
  ;; indent 2 spaces width
  (my-setup-indent 2))

;; (defun my-setup-develop-environment ()
;;   (interactive)
;;   (let ((proj-dir (file-name-directory (buffer-file-name))))
;;     ;; if hobby project path contains string "hobby-proj1"
;;     (if (string-match-p "hobby-proj1" proj-dir)
;;         (my-personal-code-style))

;;     ;; if commericial project path contains string "commerical-proj"
;;     (if (string-match-p "commerical-proj" proj-dir)
;;         (my-office-code-style))))

;; prog-mode-hook requires emacs24+
(add-hook 'prog-mode-hook 'my-personal-code-style)
;; a few major-modes does NOT inherited from prog-mode
(add-hook 'lua-mode-hook 'my-personal-code-style)
(add-hook 'web-mode-hook 'my-personal-code-style)


; mu4e
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;;(require 'smtpmail)
(setq user-mail-address "johnmastroberti123@gmail.com"
      user-full-name  "John Mastroberti"
      ;; I have my mbsyncrc in a different folder on my system, to keep it separate from the
      ;; mbsyncrc available publicly in my dotfiles. You MUST edit the following line.
      ;; Be sure that the following command is: "mbsync -c ~/.config/mu4e/mbsyncrc -a"
      mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a"
      mu4e-update-interval  300
      mu4e-main-buffer-hide-personal-addresses t
      message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.1and1.com" 587 nil nil))
      mu4e-sent-folder "/main/Sent"
      mu4e-drafts-folder "/main/Drafts"
      mu4e-trash-folder "/main/Trash"
      mu4e-maildir-shortcuts
      '(("/main/Inbox"      . ?i)
        ("/main/Sent Items" . ?s)
        ("/main/Drafts"     . ?d)
        ("/main/Trash"      . ?t)))
