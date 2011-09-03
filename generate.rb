#!/usr/bin/env ruby

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
resume = YAML::load( File.open("resume.yml") )

if ARGV[0] == "web"
  puts "Generating web version of resume..."
  outputfile = "resume-web.html"
else
  puts "Generating normal version of resume..."
  outputfile = "resume.html"

  # Load and merge contact information (for full resume)
  # private.yml contains contact information I don't want posted
  private = YAML::load( File.open("private.yml") )
  resume["contact"] = resume["contact"].merge(private["contact"])
end

# Load the ERB template (for now, only HTML)
template = ERB.new( File.new("resume.html.erb").read, 0, "%<>" )

namespace = ErbBinding.new resume
result = template.result namespace.send(:get_binding)

# Write to output file
File.open( outputfile, "w" ) do |file|
  file.write result
end
