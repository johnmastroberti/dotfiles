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
; (setq-default Tex-master nil) ; useful for multi-file documents
(setq +latex-viewers '(zathura))


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
