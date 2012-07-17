all: output/resume.html output/resume-web.html output/resume.pdf output/resume-web.pdf

output/resume.html: generate.rb resume.yml private.yml templates/resume.html.erb templates/escape_html.rb
	@./generate.rb -t resume.html.erb

output/resume-web.html: generate.rb resume.yml templates/resume.html.erb templates/escape_html.rb
	@./generate.rb -t resume.html.erb -w

output/resume.tex: generate.rb resume.yml private.yml templates/resume.tex.erb templates/escape_tex.rb
	@./generate.rb -t resume.tex.erb

output/resume.pdf: output/resume.tex res.cls
	@pdflatex -interaction=batchmode -output-directory output $<

output/resume-web.tex: generate.rb resume.yml templates/resume.tex.erb templates/escape_tex.rb
	@./generate.rb -t resume.tex.erb -w

output/resume-web.pdf: output/resume-web.tex res.cls
	@pdflatex -interaction=batchmode -output-directory output $<

.PHONY: publish
publish: output/resume-web.html output/resume-web.pdf output/resume-web.tex
	scp output/resume-web.html mhyee@mhyee.com:~/public_html/resume/YeeMing-Ho_resume_online.html
	scp output/resume-web.pdf mhyee@mhyee.com:~/public_html/resume/YeeMing-Ho_resume_online.pdf
	scp output/resume-web.tex  mhyee@mhyee.com:~/public_html/resume/YeeMing-Ho_resume_online.tex

.PHONY: clean
clean:
	rm -rf output
