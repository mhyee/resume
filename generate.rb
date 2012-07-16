#!/usr/bin/env ruby

require 'optparse'
require 'yaml'
require 'erb'
require 'ostruct'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: generate.rb [options]"
  options[:input] = 'resume.yml'
  opts.on( '-i', '--input INPUT', 'input file' ) do |input|
    options[:input] = input
  end
  options[:template] = 'resume.html.erb'
  opts.on( '-t', '--template TEMPLATE', 'template file' ) do |template|
    options[:template] = template
  end
  options[:web] = false
  opts.on( '-w', '--web', 'create a web version omitting private information' ) do |w|
    options[:web] = true
  end
end.parse!

# Semi-hack to pass the correct bindings to ERB
class ErbBinding < OpenStruct
    def get_binding
        return binding()
    end
end

# Does the resume file exist?
abort("Error: #{options[:input]} is not present in this directory.  Use -i or --input to specify another input file.") unless File.exists?( options[:input] )

# Load the resume YAML files
resume = YAML::load( File.open(options[:input]) )

# Does the template file exist?
abort("Error: template #{options[:template]} is not present in the templates directory.  Use -t or --template to specify another template file.") unless File.exists?( 'templates/' + options[:template] )

input_basename, input_extension = options[:input].split('.')
template_basename, template_extension1, template_extension2 = options[:template].split('.')

if options[:web]
  output_file = input_basename + '-web.' + template_extension1
else
  output_file = input_basename + '.' + template_extension1

  # Load and merge contact information (for full resume)
  # private.yml contains contact information I don't want posted
  private = YAML::load( File.open("private.yml") )
  resume["contact"] = resume["contact"].merge(private["contact"])
end

# Load the escape function and run it on resume hash (if escape function exists)
escape_defn = File.join( File.dirname(__FILE__), 'templates', '/escape_' + template_extension1 + '.rb' )
require escape_defn if File.exists?(escape_defn)
escape(resume) if defined?(escape)

# Load the ERB template
template = ERB.new( File.new('templates/' + options[:template]).read, 0, "<>" )

namespace = ErbBinding.new resume
result = template.result namespace.send(:get_binding)

# Create 'output' directory if it doesn't exist
Dir.mkdir("output") unless File.exists?("output") && File.directory?("output")

# Write to output file
File.open( 'output/' + output_file, "w" ) do |file|
  file.write result
end
puts "Created #{output_file}"
