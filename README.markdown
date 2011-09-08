Resume
======

This resume system stores content in a YAML file and uses Ruby's ERB templating system to handle format and layout. Currently, the only two templates are HTML and LaTeX. pdflatex then creates a PDF file from the LaTeX source.

You may notice references to a `private.yml` file and "web" and "regular" versions of a resume. This is to prevent certain contact information (eg phone number, addresses) from being uploaded to a public repository or website.

This system is inspired by [David Hu's][]. In fact, it may be more accurate to say that this is my implementation of David's idea, with a few of my own tweaks.

If you are interested in how this works, the templates are included in this repository. The generated resumes are on [my site][], as is a brief-ish [blog post][].

[David Hu's]: https://github.com/divad12/resume
[my site]: http://csclub.uwaterloo.ca/~m5yee/resume.html
[blog post]: http://csclub.uwaterloo.ca/~m5yee/blog/yaml_resume.html

To use this for your own resume
-------------------------------

It should go without saying that your resume is made up from your experiences. My content comes from my experiences, so please don't copy it.

Also, since a unique layout stands out, I would strongly encourage you to create your own templates, though you can use mine as examples. I would suggest creating the template only after you have a good idea of the layout -- I learned the hard way that writing LaTeX and Ruby code at the same time (and compiling the template twice) is more trouble than it's worth.

### Dependencies
* Ruby
* LaTeX
