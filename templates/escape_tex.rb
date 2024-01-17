CPP_TEX = '{C\nolinebreak[4]\hspace{-.05em}\raisebox{.3ex}{\relsize{-1}{\textbf{++}}}}'

def escape(input='')
  case input
  when Hash
    input.values.map{|v| escape(v)}
  when Array
    input.map{|elt| escape(elt)}
  when String
    # Do the actual escaping here
    input.gsub!(/\[&\]/, "\\\\&")               # Ampersands
    input.gsub!(/\[LaTeX\]/, "\\\\LaTeX{}")     # LaTeX
    input.gsub!(/\[``\]/, "``")                 # Smart quotes (open)
    input.gsub!(/\[''\]/, "''")                 # Smart quotes (close)
    input.gsub!(/\[#\]/, "\\\\#")               # Number sign
    input.gsub!(/\[\$\]/, "\\\\$")              # Dollar sign
    input.gsub!(/\[%\]/, "\\\\%")               # Percent sign
    input.gsub!(/\[---\]/, "---")               # Em dash
    input.gsub!(/\[--\]/, "--")                 # En dash
    input.gsub!(/\[(.*?)\]\((.*?)\)/, "\\\\href{\\2}{\\1}")   # Link handling
    input.gsub!(/\[CPP\]/, CPP_TEX)             # C++
    input.gsub!(/\[MH Yee\]/, "\\textbf{MH Yee}") # Bold name in pubs
  else
    input
  end
end
