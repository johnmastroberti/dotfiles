(TeX-add-style-hook
 "jm-macro-general"
 (lambda ()
   (TeX-add-symbols
    '("pdc" 3)
    '("pd" 2)
    '("td" 2)
    "pp"
    "uu"
    "vv"
    "ww"
    "xx"
    "yy"
    "zz"
    "rr"
    "rrr"
    "ppp"
    "xxx"
    "nnot"
    "C"
    "R"
    "N"
    "OO"
    "del"
    "oldemptyset"
    "emptyset")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

