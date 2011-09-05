all: resume.html resume-web.html resume.pdf

resume.html: generate.rb resume.yml private.yml resume.html.erb
	@./generate.rb html

resume-web.html: generate.rb resume.yml resume.html.erb
	@./generate.rb html web

resume.tex: generate.rb resume.yml private.yml resume.tex.erb
	@./generate.rb tex

resume.pdf: resume.tex res.cls
	@pdflatex -interaction=batchmode resume.tex

.PHONY: clean
clean:
	rm -rf resume.html
	rm -rf resume-web.html
	rm -rf resume.tex
	rm -rf resume.pdf
	rm -rf resume.log
