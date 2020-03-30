.PHONY: clean withversion run

MDFILES=00_intro.md 01_intro.md 02_mf.md 03_ea.md 02_rm.md  04_lpm.md 05_ra.md \
06_sql.md 06_sql_ddl.md 06_sql_dcl.md 11_access.md 09_bigd.md

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

clean:
	rm -f $(OUTPUT)

test.pdf: 11_access.md
	cat 00_intro.md 11_access.md > test.md
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US test.md -o test.pdf $(FONTOPTIONS)

sql.pdf: 06_sql.md 06_sql_ddl.md 06_sql_dcl.md
	cat 00_intro.md 06_sql.md 06_sql_ddl.md 06_sql_dcl.md > test.md 
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US test.md -o sql.pdf $(FONTOPTIONS)
	
07_tools.pdf: 07_tools.md
		cat 00_base.md 07_tools.md > test.md
		pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US test.md -o 07_tools.pdf $(FONTOPTIONS)

11_access.pdf: 11_access.md
	cat 00_base.md 11_access.md > test.md
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US test.md -o 11_access.pdf $(FONTOPTIONS)

09_bigd.pdf: 09_bigd.md 
	cat 00_base.md 09_bigd.md > test.md
	pandoc --slide-level 3 -st beamer -V theme:$(THEME) -V lang:en-US test.md -o 09_bigd.pdf $(FONTOPTIONS)
