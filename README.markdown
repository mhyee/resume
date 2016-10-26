Resume
======

This resume system stores content in a YAML file and uses Ruby's ERB templating
system to handle format and layout. Currently, the three templates implemented
are HTML, LaTeX, and plain text. You can use pdflatex to create a PDF file from
the generated LaTeX file.

`escape_html.rb`, `escape_tex.rb`, and `escape_txt.rb` define `escape` functions
for handling special characters or cases. (For example, `&` must be escaped as
`\&amp;` in HTML, and `\\&` in LaTeX. The `escape` function also handles other
special cases, including links.) Escape characters must appear in square
brackets in the YAML file. For example, to include an ampersand, use `[&]`.

Store private contact information in the `private.yml` file. This information
will be omitted from the "web" version of the generated resume (selected with
the `-w` or `--web` option). This is to prevent certain contact information
(e.g. phone number, address) from being uploaded to a public repository or
website. For an example, see `private.example.yml`.

This project was inspired by [David Hu's resume project][].

For examples, my templates are included in this repository, while the generated
resumes are on [my website][].

[David Hu's resume project]: https://github.com/divad12/resume
[my website]: http://mhyee.com/resume.html

### Usage

Feel free to fork or use this project and adapt the templates for your own
resume. (Obviously, the resume content is mine.)

    Usage: generate.rb [options]
        -i, --input INPUT                input file
        -p, --private PRIVATE            private input file
        -t, --template TEMPLATE          template file
        -w, --web                        create a web version omitting private information

### Dependencies
* Ruby
* LaTeX

### License

The resume content in this repo, `resume.yml` is copyrighted by Ming-Ho Yee.

The rest of the project is licensed under the MIT License.

### Contributions

This project was always intended to solve a very specific, personal problem,
rather than to be for general use. However, I am more than happy to review pull
requests. If the changes are compatible with my use case, I'll accept them.

I would like to thank [tshieh][] for adding OptionParser and updating the
documentation.

[tshieh]: https://github.com/tshieh
