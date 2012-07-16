Resume
======

This resume system stores content in a YAML file and uses Ruby's ERB templating system to handle format and layout.  Currently, the only two templates implemented are HTML and LaTeX. You can use pdflatex to create a PDF file from the generated LaTeX file.

`escape_html.rb` and `escape_tex.rb` define `escape` functions for handling special characters in LaTex or HTML.  (For example, & must be escaped as \&amp; in HTML, and \\& in LaTeX.  The `escape` function also handles other special cases, including links.)  Escape characters must appear in square brackets in the YAML file.  For example, to include an ampersand, use [&].

Store private contact information in the `private.yml` file.  This information will be omitted from the "web" version of the generated resume (selected with the -w or --web option).  This is to prevent certain contact information (e.g. phone number, address) from being uploaded to a public repository or website. For an example, see `private.example.yml`.

This is a fork of [Ming-Ho Yee's resume project], which in turn was inspired by [David Hu's resume project].

[Ming-Ho Yee's resume project]: https://github.com/mhyee/resume
[David Hu's resume project]: https://github.com/divad12/resume


### Dependencies
* Ruby
* LaTeX
