all: output/resume.html output/resume-web.html output/resume.pdf output/resume-web.pdf

output/resume.html: generate.rb resume.yml private.yml templates/resume.html.erb
	@./generate.rb html

output/resume-web.html: generate.rb resume.yml templates/resume.html.erb
	@./generate.rb html web

output/resume.tex: generate.rb resume.yml private.yml templates/resume.tex.erb
	@./generate.rb tex

output/resume.pdf: output/resume.tex res.cls
	@pdflatex -interaction=batchmode -output-directory output $<

output/resume-web.tex: generate.rb resume.yml templates/resume.tex.erb
	@./generate.rb tex web

output/resume-web.pdf: output/resume-web.tex res.cls
	@pdflatex -interaction=batchmode -output-directory output $<

.PHONY: publish
publish: resume-web.html resume-web.pdf resume-web.tex
	scp resume-web.html mhyee@mhyee.com:~/www/resume/YeeMing-Ho_resume_online.html
	scp resume-web.pdf mhyee@mhyee.com~/www/resume/YeeMing-Ho_resume_online.pdf
	scp resume-web.tex  mhyee@mhyee.com~/www/resume/YeeMing-Ho_resume_online.tex

.PHONY: clean
clean:
	rm -rf output
