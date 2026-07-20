ASCIIDOCTOR     := ~/.local/share/gem/ruby/3.3.0/bin/asciidoctor
ASCIIDOCTOR_PDF := ~/.local/share/gem/ruby/3.3.0/bin/asciidoctor-pdf

.PHONY: all html pdf clean

all: html pdf

html:
	$(ASCIIDOCTOR) demo.adoc -o demo.html

pdf:
	$(ASCIIDOCTOR_PDF) demo.adoc -o demo.pdf

clean:
	rm -f demo.html demo.pdf
