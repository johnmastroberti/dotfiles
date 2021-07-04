(TeX-add-style-hook
 "jm-macro-em"
 (lambda ()
   (TeX-add-symbols
    '("kk" 1)
    "EE"
    "BB"
    "eps"
    "JJ"
    "FF"
    "nn")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

