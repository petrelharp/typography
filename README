
This is my attempt to easily make nice html versions of latex papers, using LaTeXML plus some css.

If your LaTeX is similar to mine, you can just type 
    make (name-of-latex-file-without-.tex).xhtml
and get a nice .xhtml file.  If you want to adjust settings, read the latexmlpost documentation.

You almost certainly want to get your images in appropriate formats and sizes first, so latexml doesn't have to guess at that for you.

To get my figures nice, I used inkscape to make all my pdfs into svgs; you can do this with
    inkscape example.pdf --export-plain-svg=example.svg
.. then, to get this to resize correctly in the html, I had to add a little bit of javascript, that's in adjust-svg.js.

The css was modeled after [trvrb's](https://github.com/trvrb) really [nice looking paper](http://www.trevorbedford.com/canalization/index.html).

Help me, or better yet, (Bruce Miller)[http://dlmf.nist.gov/LaTeXML/contact.html] improve this stuff!

References:
* [LaTeXML](http://dlmf.nist.gov/LaTeXML/)
