(TeX-add-style-hook
 "jm-macro-quantum"
 (lambda ()
   (TeX-run-style-hooks
    "braket")
   (TeX-add-symbols
    "intii"
    "intoi"
    "HH"
    "tr")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

