;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Niku"
      user-mail-address "gronbergniku@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-monokai-pro)
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq-default fill-column -1)

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

;; Font options
(setq doom-font (font-spec :family "Lucida Console" :size 16))
(setq-default line-spacing 0.3)


;; Setup folder
(setq default-directory "~/Documents/")

;; Setup projectile
(setq projectile-project-search-path '("~/Documents/Codes/" "~/.doom.d/" "~/Documents/repos/"))

;; Window size on startup
(setq initial-frame-alist '((width . 175) (height . 65)))

;; Prettier config
(setq +format-with-lsp nil)
(add-hook 'web-mode-hook 'prettier-js-mode)

;; Custom keybinds
(map! :g "M-k" 'drag-stuff-up
      :g "M-j" 'drag-stuff-down)

(map! :leader
      :desc "Toggle popups"
      "t p" #'+popup/toggle)

(map! :leader
      :desc "Toggle Treemacs"
      "t t" #'treemacs)

;; Experimental Typescript support in .tsx files
(use-package! tree-sitter
  :config
  (setq tree-sitter-hl-use-font-lock-keywords t)
  (add-hook! typescript-tsx-mode #'tree-sitter-hl-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-tsx-mode))
)
(use-package! tree-sitter-langs
  :after tree-sitter
  :config
  (tree-sitter-require 'tsx)
  (tree-sitter-require 'typescript)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx))
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-mode . typescript))
)

;; Fix company autocomplete freezing in tsx mode
(defun web-mode-hook ()
  "Hooks for Web mode."
  (remove-hook 'yas-after-exit-snippet-hook
               'web-mode-yasnippet-exit-hook t)
  (remove-hook 'yas/after-exit-snippet-hook
               'web-mode-yasnippet-exit-hook t)
  )
(add-hook 'web-mode-hook  'web-mode-hook)

;; Set default tabs to 2 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
;;(setq indent-line-function 'insert-tab)
(setq
  web-mode-markup-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-code-indent-offset 2
  js-indent-level 2
  typescript-indent-level 2
)

;; Tailwind css lsp
(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t)
)
