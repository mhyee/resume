def escape(input='')
  case input
  when Hash
    input.values.map{|v| escape(v)}
  when Array
    input.map{|elt| escape(elt)}
  when String
    # Do the actual escaping here
    input.gsub!(/\[&\]/, '&;')            # Ampersands
    input.gsub!(/\[LaTeX\]/, 'LaTeX')     # LaTeX
    input.gsub!(/\[``\]/, '"')           # Smart quotes (open)
    input.gsub!(/\[''\]/, '"')           # Smart quotes (close)
    input.gsub!(/\[#\]/, '#')             # Number sign
    input.gsub!(/\[\$\]/, '$')            # Dollar sign
    input.gsub!(/\[%\]/, '%')             # Percent sign
    input.gsub!(/\[---\]/, '---')         # Em dash
    input.gsub!(/\[--\]/, '--')           # En dash
    # Don't need to escape links for txt resume
    input.gsub!(/\[CPP\]/, 'C++')         # C++
    input.gsub!(/\[MH Yee\]/, 'MH Yee')   # Do nothing for name in pubs
  else
    input
  end
end

def wrap(text, indent=0)
  spaces = " " * indent

  # The regex matches up to 74 characters, then whitespace or end of line.
  # The whitespace or end of line is replaced by a linebreak, followed by
  # indentation.
  text
    .gsub(/\]\(/, "] (")                        # allow breaks in URL tags
    .gsub(/(.{1,74})(\s+|$)/, "\\1\n#{spaces}") # insert a linebreak after 74 columns
    .gsub(/\] \(/, "](")                        # remove extraneous space in URL tags
    .strip                                      # remove extra whitespace
end
