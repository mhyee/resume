all: output/resume.txt output/resume-web.txt output/resume.html output/resume-web.html output/resume.pdf output/resume-web.pdf

output/resume.txt: generate.rb resume.yml private.yml templates/resume.txt.erb templates/escape_txt.rb
	@./generate.rb -t resume.txt.erb

output/resume-web.txt: generate.rb resume.yml templates/resume.txt.erb templates/escape_txt.rb
	@./generate.rb -t resume.txt.erb -w

output/resume.html: generate.rb resume.yml private.yml templates/resume.html.erb templates/escape_html.rb
	@./generate.rb -t resume.html.erb

output/resume-web.html: generate.rb resume.yml templates/resume.html.erb templates/escape_html.rb
	@./generate.rb -t resume.html.erb -w

output/resume.tex: generate.rb resume.yml private.yml templates/resume.tex.erb templates/escape_tex.rb
	@./generate.rb -t resume.tex.erb

output/resume.pdf: output/resume.tex
	@pdflatex -interaction=batchmode -output-directory output $<

output/resume-web.tex: generate.rb resume.yml templates/resume.tex.erb templates/escape_tex.rb
	@./generate.rb -t resume.tex.erb -w

output/resume-web.pdf: output/resume-web.tex
	@pdflatex -interaction=batchmode -output-directory output $<

.PHONY: publish
publish: output/resume-web.txt output/resume-web.html output/resume-web.pdf output/resume-web.tex
	mkdir temp
	cp output/resume-web.txt temp/resume.txt
	cp output/resume-web.html temp/resume.html
	cp output/resume-web.pdf temp/resume.pdf
	cp output/resume-web.tex temp/resume.tex
	rsync -r -a -v -e "ssh -l mhyee" temp/ mhyee.com:~/public_html/resume/
	rm -rf temp

.PHONY: clean
clean:
	rm -rf output
