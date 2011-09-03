require 'yaml'
require 'erb'
require 'ostruct'

# Semi-hack to pass the correct bindings to ERB
class ErbBinding < OpenStruct
    def get_binding
        return binding()
    end
end

# Load the resume YAML files
# private.yml contains contact information I don't want posted
resume = YAML::load( File.open('resume.yml') )
private = YAML::load( File.open('private.yml') )

# Merge the contact information
resume["contact"] = resume["contact"].merge(private["contact"])

# Load the ERB template (for now, only HTML)
template = ERB.new( File.new('resume.html.erb').read, 0, "%<>" )

namespace = ErbBinding.new resume
result = template.result namespace.send(:get_binding)

# Write to output file
File.open( 'resume.html', 'w' ) do |file|
  file.write result
end
