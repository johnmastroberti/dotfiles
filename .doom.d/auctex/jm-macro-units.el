(TeX-add-style-hook
 "jm-macro-units"
 (lambda ()
   (TeX-add-symbols
    "s"
    "m"
    "eV"
    "MeV")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

