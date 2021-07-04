(TeX-add-style-hook
 "jm"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "margin=1in") ("babel" "english") ("csquotes" "autostyle" "english=american")))
   (TeX-run-style-hooks
    "geometry"
    "amsmath"
    "amsthm"
    "amssymb"
    "graphicx"
    "textcomp"
    "gensymb"
    "cite"
    "multicol"
    "mathtools"
    "color"
    "babel"
    "csquotes"
    "tikz"
    "pgfplots"
    "jm-macro-general"
    "jm-macro-classical"
    "jm-macro-quantum"
    "jm-macro-em"
    "jm-macro-units"
    "jm-env")
   (LaTeX-add-environments
    '("solution" LaTeX-env-args ["argument"] 1)
    '("problem" LaTeX-env-args ["argument"] 1)))
 :latex)

