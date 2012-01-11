def escape(input='')
  case input
  when Hash
    input.values.map{|v| escape(v)}
  when Array
    input.map{|elt| escape(elt)}
  when String
    # Do the actual escaping here
    input.gsub!(/\[&\]/, "&amp;")      # Ampersands
    input.gsub!(/\[LaTeX\]/, "LaTeX")  # LaTeX
    input.gsub!(/\[LaTeX \]/, "LaTeX") # LaTeX (trailing space)
    input.gsub!(/\[``\]/, "&ldquo;")   # Smart quotes (open)
    input.gsub!(/\[''\]/, "&rdquo;")   # Smart quotes (close)
    input.gsub!(/\[(.*)\]\((.*)\)/, "<a href=\"\\2\">\\1</a>")   # Link handling
  else
    input
  end
end
