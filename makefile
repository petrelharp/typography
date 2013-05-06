%.xml : %.tex
	latexml --destination=$@ $<

%.xhtml : %.xml
	latexmlpost --css=plr-style.css --destination=$@ $<
	cp plr-style.css $(@D)

ibd/ibd-writeup.xhtml : ibd/ibd-writeup.tex
	rm ibd/LaTeXML.cache
	latexml --destination=ibd/ibd-writeup.xml $<
	latexmlpost --split --splitpath="//ltx:bibliography |//ltx:appendix" --css=plr-style.css --destination=$@ ibd/ibd-writeup.xml
	cp plr-style.css ibd

%.svg : %.pdf
	inkscape $< --export-plain-svg=$@

%.png : %.pdf
	convert -density 300 $< -flatten $@

##
# from WorkingWiki (lee worden)


# set $deps to list of files referenced by \include and \input commands
define get_dependencies
	deps=`perl -ne '($$_)=/^[^%]*\\\(?:include|input)(?:\s+|\{)([^\\\\]*?)(?:\}|\s+|$$)/;@_=split /,/;foreach $$t (@_) { if($$t =~ /.tex$$/) { print "$$t "; } else { print "$$t.tex " } }' $*.tex`
endef

# set $bibs to list of .bib files referenced by \bibliography in the tex file
define getbibs
	bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{([^\\\\]*?)\}/;@_=split /,/;foreach $$b (@_) { $$b =~ s/\.bib$$//; print "$$b.bib "}' $*.tex $$deps`
endef

# for latexml: set $bibxmls to list of .bib.xml files, one for each .bib
# in $bibs; set $bibxargs to list containing --bibliography=X.bib.xml for each
# .bib in $bibs, suitable for the argument list of latexmlpost.
define getbx
	bibxmls=`perl -ne '($$_)=/^[^%]*\\\bibliography\{([^\\\\]*?)\}/;@_=split /,/;foreach $$b (@_) { $$b =~ s/\.bib$$//; print "$$b.bib.xml "}' $*.tex $$deps` ;\
	bibxargs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{([^\\\\]*?)\}/;@_=split /,/;foreach $$b (@_) { $$b =~ s/\.bib$$//; print "--bibliography=$$b.bib.xml "}' $*.tex $$deps`
endef

# set $figs to list of all image files referenced by \includegraphics or
# \psfig in the tex file
# $(1) is the default figuretype: in latex \includegraphics{filename} is
# usually a shorthand for filename.eps, while in pdflatex it's filename.pdf
# it's possible to reconfigure this default in the latex source, in which
# case this makefile will guess wrong what image files are dependencies.
define getfigs
	figs=`perl -ne '@foo=/^[^%]*\\\(includegraphics|psfig)(\[.*?\])?\{([^\\\\]*?)\}/g;if (defined($$foo[2])) { if ($$foo[2] =~ /\./) { print "$$foo[2] "; } else { print "$$foo[2].$(1) "; }}' $*.tex $$deps`
endef

