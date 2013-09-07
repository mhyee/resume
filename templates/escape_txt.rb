def escape(input='')
  case input
  when Hash
    input.values.map{|v| escape(v)}
  when Array
    input.map{|elt| escape(elt)}
  when String
    # Do the actual escaping here
    input.gsub!(/\[&\]/, "&;")            # Ampersands
    input.gsub!(/\[LaTeX\]/, "LaTeX")     # LaTeX
    input.gsub!(/\[LaTeX \]/, "LaTeX ")   # LaTeX (trailing space)
    input.gsub!(/\[``\]/, "\"")           # Smart quotes (open)
    input.gsub!(/\[''\]/, "\"")           # Smart quotes (close)
    input.gsub!(/\[#\]/, "#")             # Number sign
    input.gsub!(/\[\$\]/, "$")            # Dollar sign
    # Don't need to escape links for txt resume
  else
    input
  end
end
