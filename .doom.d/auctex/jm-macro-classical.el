(TeX-add-style-hook
 "jm-macro-classical"
 (lambda ()
   (TeX-add-symbols
    "Tnet"
    "TT"
    "Fnet"
    "LL"
    "Lg")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

