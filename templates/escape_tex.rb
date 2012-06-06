def escape(input='')
  case input
  when Hash
    input.values.map{|v| escape(v)}
  when Array
    input.map{|elt| escape(elt)}
  when String
    # Do the actual escaping here
    input.gsub!(/\[&\]/, "\\\\&")               # Ampersands
    input.gsub!(/\[LaTeX\]/, "\\\\LaTeX")       # LaTeX
    input.gsub!(/\[LaTeX \]/, "\\\\LaTeX\\\\")  # LaTeX (trailing space)
    input.gsub!(/\[``\]/, "``")                 # Smart quotes (open)
    input.gsub!(/\[''\]/, "''")                 # Smart quotes (close)
    input.gsub!(/\[\+\]/, "$+$")                # Plus sign
    input.gsub!(/\[#\]/, "\\\\#")               # Number sign
    input.gsub!(/\[(.*)\]\((.*)\)/, "\\\\href{\\2}{\\1}")   # Link handling
  else
    input
  end
end
