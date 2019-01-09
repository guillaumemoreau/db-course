.PHONY: clean withversion run

MDFILES=00_intro.md 01_intro.md 02_mf.md 03_ea.md 04_lpm.md 05_ra.md 06_sql.md

INPUT=slides.md
OUTPUT=slides.pdf
DEP=$(wildcard *.sty *.jpg *.png)
THEME=Custom
FONTOPTIONS=--pdf-engine=xelatex --variable mainfont="Titillium"


$(OUTPUT): $(INPUT) $(DEP)
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US $(INPUT) -o $(OUTPUT) $(FONTOPTIONS)

$(INPUT): $(MDFILES)
		cat $(MDFILES) > $(INPUT)

withversion: $(INPUT) $(DEP)
	<$(INPUT) ./inject_version |\
		pandoc -st beamer -V theme:$(THEME) -V lang:en-US -o $(OUTPUT) $(FONTOPTIONS)

run: $(OUTPUT)
	impressive -t Crossfade --nologo $(OUTPUT)

clean:
	rm -f $(OUTPUT)

test.pdf: 06_sql.md
	cat 00_intro.md 06_sql.md > $(INPUT)
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US $(INPUT) -o test.pdf $(FONTOPTIONS)
