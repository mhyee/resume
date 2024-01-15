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
    input.gsub!(/\[``\]/, "\"")           # Smart quotes (open)
    input.gsub!(/\[''\]/, "\"")           # Smart quotes (close)
    input.gsub!(/\[#\]/, "#")             # Number sign
    input.gsub!(/\[\$\]/, "$")            # Dollar sign
    input.gsub!(/\[---\]/, "---")         # Em dash
    input.gsub!(/\[--\]/, "--")           # En dash
    # Don't need to escape links for txt resume
    input.gsub!(/\[CPP\]/, "C++")         # C++
    input.gsub!(/\[MH Yee\]/, "MH Yee")   # Do nothing for name in pubs
  else
    input
  end
end
