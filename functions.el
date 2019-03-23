;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-

(defun GenerateDrillEntry (args)
  "Generate Drill Entry form Quizlet set export file with liens fench - english pairs"
  (interactive "P")
  (let (line words template)
    (setq line (buffer-substring-no-properties
                (line-beginning-position)
                (line-end-position)))
    (while (not (string= "" line))
      (setq words (split-string line " - "))
      (setq template (format "
***** Word :drill:
%s

****** Magyar
%s
" (car words) (car (cdr words))))
      (delete-region (line-beginning-position) (line-end-position))
      (insert template)
      (forward-line)
      (setq line (buffer-substring-no-properties
                  (line-beginning-position)
                  (line-end-position)))
      )
    )
  )
