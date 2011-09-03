all: resume.html resume-web.html

resume.html: generate.rb resume.yml private.yml resume.html.erb
	./generate.rb

resume-web.html: generate.rb resume.yml resume.html.erb
	./generate.rb web

.PHONY: clean
clean:
	rm -rf resume.html
	rm -rf resume-web.html
