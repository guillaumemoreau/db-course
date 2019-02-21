all: 01_select.pdf 02_db.pdf 

01_select.pdf: 01_select.md
	pandoc -o 01_select.pdf 01_select.md -V lang:en-US --pdf-engine=xelatex --variable mainfont="Titillium"

02_db.pdf: 02_db.md
		pandoc -o 02_db.pdf 02_db.md -V lang:en-US --pdf-engine=xelatex --variable mainfont="Titillium"
