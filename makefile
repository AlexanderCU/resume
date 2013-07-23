TEXS := $(wildcard *.tex)
PDFS := $(patsubst %.tex,%.pdf,$(TEXS))
TXTS := $(patsubst %.tex,%.txt,$(TEXS))
LOGS := $(patsubst %.tex,%.log,$(TEXS))
AUXS := $(patsubst %.tex,%.aux,$(TEXS))
DVIS := $(patsubst %.tex,%.dvi,$(TEXS))


all: $(PDFS) $(TXTS)
  
%.pdf: %.tex
	pdflatex $<

%.txt: %.tex
	latex $<
	catdvi -e 1 -U $(addsuffix .dvi, $(basename $<)) | sed -re "s/\[U\+2022\]/*/g" | sed -re "s/([^^[:space:]])\s+/\1 /g" > $(addsuffix .txt, $(basename $<))

clean:
	rm -f $(LOGS) $(AUXS) $(DVIS)

clean-all:
	rm -f $(PDFS) $(TXTS) $(LOGS) $(AUXS) $(DVIS)

.PHONY: clean all
