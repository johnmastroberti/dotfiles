(TeX-add-style-hook
 "jm-env"
 (lambda ()
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

