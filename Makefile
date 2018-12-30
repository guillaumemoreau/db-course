.PHONY: clean withversion run

INPUT=slides.md
OUTPUT=slides.pdf
DEP=$(wildcard *.sty *.jpg *.png)
THEME=Custom
FONTOPTIONS=--pdf-engine=xelatex --variable mainfont="Titillium"

$(OUTPUT): $(INPUT) $(DEP)
	pandoc -st beamer -V theme:$(THEME) -V lang:fr-FR $(INPUT) -o $(OUTPUT) $(FONTOPTIONS)

withversion: $(INPUT) $(DEP)
	<$(INPUT) ./inject_version |\
		pandoc -st beamer -V theme:$(THEME) -V lang:fr-FR -o $(OUTPUT) $(FONTOPTIONS)

run: $(OUTPUT)
	impressive -t Crossfade --nologo $(OUTPUT)

clean:
	rm -f $(OUTPUT)
