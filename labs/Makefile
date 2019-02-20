all: 01_select.pdf

01_select.pdf: 01_select.md
	pandoc -o 01_select.pdf 01_select.md -V lang:en-US --pdf-engine=xelatex --variable mainfont="Titillium"
