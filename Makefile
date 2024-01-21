SHELL := /bin/bash

EXTS    := html pdf tex txt
PRV_OUT := $(addprefix output/resume., $(EXTS))
WEB_OUT := $(addprefix output/resume-web., $(EXTS))

TEMPLATES  := templates/resume.%.erb templates/escape_%.rb
WEB_PREREQ := $(TEMPLATES) generate.rb resume.yml

all: $(PRV_OUT) $(WEB_OUT)

output/resume.%: $(WEB_PREREQ) private.yml
	@./generate.rb -t templates/resume.$*.erb

output/resume-web.%: $(WEB_PREREQ)
	@./generate.rb -t templates/resume.$*.erb -w

output/%.pdf: output/%.tex
	@echo "Created $(@:output/%=%)"
	@pdflatex -interaction=batchmode -output-directory output $< > /dev/null

publish: $(WEB_OUT)
	mkdir -p temp
	for f in $^; do cp $$f $${f/output/temp}; done
	for f in temp/*; do mv $$f $${f/-web/}; done
	rsync -azv temp/ mhyee.com:~/public_html/resume/
	rm -rf temp

clean:
	rm -rf output temp

.PHONY: all publish clean
