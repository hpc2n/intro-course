(TeX-add-style-hook
 "slides-sep-2021"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer10"
    "graphics"
    "graphicx"
    "hyperref"
    "amsmath"
    "amssymb"
    "amsthm"
    "color"
    "multirow"
    "ragged2e"
    "verbatim"
    "listings"
    "ulem"
    "hhline"
    "tikz")
   (TeX-add-symbols
    "R"
    "Rn"
    "Rp"
    "Rnn"
    "Rnp"
    "myspan"
    "be"
    "ee"
    "bes"
    "ees"
    "bbm"
    "ebm"
    "bpm"
    "epm"
    "Ran"
    "Ker"
    "fl")
   (LaTeX-add-amsthm-newtheorems
    "algorithm"))
 :latex)

