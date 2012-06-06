LATEX_HTML = %~<span style="font-family:cmr10,'Latin Modern Roman',serif">L<span style="text-transform: uppercase; font-size: 70%; margin-left: -0.36em; vertical-align: 0.3em; line-height: 0; margin-right: -0.15em">a</span>T<span style="text-transform: uppercase; margin-left: -0.1667em; vertical-align: -0.5ex; line-height: 0; margin-right: -0.125em">e</span>X</span>~

def escape(input='')
  case input
  when Hash
    input.values.map{|v| escape(v)}
  when Array
    input.map{|elt| escape(elt)}
  when String
    # Do the actual escaping here
    input.gsub!(/\[&\]/, "&amp;")         # Ampersands
    input.gsub!(/\[LaTeX\]/, LATEX_HTML)  # LaTeX
    input.gsub!(/\[LaTeX \]/, LATEX_HTML) # LaTeX (trailing space)
    input.gsub!(/\[``\]/, "&ldquo;")      # Smart quotes (open)
    input.gsub!(/\[''\]/, "&rdquo;")      # Smart quotes (close)
    input.gsub!(/\[\+\]/, "+")            # Plus sign
    input.gsub!(/\[#\]/, "#")             # Number sign
    input.gsub!(/\[(.*)\]\((.*)\)/, "<a href=\"\\2\">\\1</a>")   # Link handling
  else
    input
  end
end
