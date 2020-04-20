.PHONY: clean withversion run

MDFILES=00_intro.md 00_orga.md 01_intro.md 

INPUT=slides.md
OUTPUT=slides.pdf
DEP=$(wildcard *.sty *.jpg *.png)
THEME=Custom
FONTOPTIONS=--pdf-engine=xelatex --variable mainfont="Titillium" --variable fontsize=10pt


$(OUTPUT): $(INPUT) $(DEP)
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US $(INPUT) -o $(OUTPUT) $(FONTOPTIONS)

$(INPUT): $(MDFILES)
		cat $(MDFILES) > $(INPUT)

withversion: $(INPUT) $(DEP)
	<$(INPUT) ./inject_version |\
		pandoc -st beamer -V theme:$(THEME) -V lang:en-US -o $(OUTPUT) $(FONTOPTIONS)

run: $(OUTPUT)
	impressive -t Crossfade --nologo $(OUTPUT)

