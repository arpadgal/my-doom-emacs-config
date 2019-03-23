;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(yas-global-mode 1)
;;Theme
(setq doom-font (font-spec :family "Space Mono for Powerline" :size 18)
      doom-variable-pitch-font (font-spec :family "Space Mono for Powerline")
      doom-unicode-font (font-spec :family "Space Mono for Powerline")
      doom-big-font (font-spec :family "Space Mono for Powerline" :size 31))
(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-tomorrow-night t) ;doom-one
(doom-themes-org-config)

(doom-themes-treemacs-config)
(doom-themes-neotree-config)
;; End Theme

;;GTD begin
(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))
;;(setq org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5)))
(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                           ("~/gtd/someday.org" :level . 1)
                           ("~/gtd/tickler.org" :maxlevel . 2)))
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-agenda-custom-commands
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

;;GTD end
(setq org-agenda-log-mode-items '(state clock))

(setq projectile-git-submodule-command nil)
;;(add-hook! dired-mode-hook (all-the-icons-dired-mode))
;;(add-hook! ranger-mode-hook all-the-icons-dired-mode)

(def-package! org-clock-convenience
    :bind (:map org-agenda-mode-map
   	            ("<S-up>" . org-clock-convenience-timestamp-up)
   	            ("<S-down>" . org-clock-convenience-timestamp-down)
   	            ("<S-right>" . org-clock-convenience-fill-gap)
   	            ("<S-left>" . org-clock-convenience-fill-gap-both)))

(def-package! treemacs-icons-dired
  :after treemacs dired
  :config (treemacs-icons-dired-mode))
;;  :hook (dired-mode . treemacs-icons-dired-mode))

(def-package! ahk-mode)
(require 'org-drill)

(after! treemacs
(treemacs-reset-icons))

;;(add-hook! dired-mode-hook treemacs-icons-dired-mode)
;;(add-hook! ranger-mode-hook treemacs-icons-dired-mode)


(map! :leader
      (:prefix ("o" . "open")
        :desc "Ranger"              "r"   #'ranger
        :desc "Treemacs"              "t"   #'treemacs))
