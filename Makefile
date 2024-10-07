SRC = missa.cls missabooklet.sty missaleaflet.sty
INSTALLDIR = $(HOME)/.local/share/latex
.PHONY = install test
EGPDIR = examples/prayers
EGRDIR = examples/readings
EGPRAYERS = $(EGPDIR)/creed1.tex $(EGPDIR)/creed2.tex $(EGPDIR)/gloria.tex $(EGPDIR)/ourfather.tex $(EGPDIR)/sanctus.tex $(EGPDIR)/sanctus-la.tex
EGREADS = $(EGRDIR)/reading1.tex $(EGRDIR)/reading2.tex $(EGRDIR)/gospel.tex $(EGRDIR)/gospelSat.tex

install: $(SRC)
	mkdir -p $(INSTALLDIR)
	cp $(SRC) -t $(INSTALLDIR)
	cd ~ && kpsewhich missa.cls

test: $(SRC) examples/test.tex
	for f in $(SRC); do ln -sf "../$$f" "examples/$$f"; done
	cd examples && latexmk -auxdir=latexmk -c && latexmk -auxdir=latexmk -pdf
