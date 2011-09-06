all: resume.html resume-web.html resume.pdf resume-web.pdf

resume.html: generate.rb resume.yml private.yml resume.html.erb
	@./generate.rb html

resume-web.html: generate.rb resume.yml resume.html.erb
	@./generate.rb html web

resume.tex: generate.rb resume.yml private.yml resume.tex.erb
	@./generate.rb tex

resume.pdf: resume.tex res.cls
	@pdflatex -interaction=batchmode resume.tex

resume-web.tex: generate.rb resume.yml resume.tex.erb
	@./generate.rb tex web

resume-web.pdf: resume-web.tex res.cls
	@pdflatex -interaction=batchmode resume-web.tex

.PHONY: publish
publish: resume-web.html resume-web.pdf resume-web.tex
	scp resume-web.html m5yee@csclub.uwaterloo.ca:~/www/resume/YeeMing-Ho_resume_online.html
	scp resume-web.pdf m5yee@csclub.uwaterloo.ca:~/www/resume/YeeMing-Ho_resume_online.pdf
	scp resume-web.tex  m5yee@csclub.uwaterloo.ca:~/www/resume/YeeMing-Ho_resume_online.tex

.PHONY: clean
clean:
	rm -rf resume.html resume-web.html
	rm -rf resume.tex resume-web.tex
	rm -rf resume.log resume-web.log
	rm -rf resume.pdf resume-web.pdf
