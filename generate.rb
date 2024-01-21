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
  options[:private] = 'private.yml'
  opts.on( '-p', '--private PRIVATE', 'private input file' ) do |private|
    options[:private] = private
  end
  options[:template] = 'templates/resume.html.erb'
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
abort("Error: #{options[:input]} is not present in this directory.  Use -i or --input to specify another input file.") unless File.exist?( options[:input] )

# Load the resume YAML files
resume = YAML::load( File.open(options[:input]) )

# Does the private input file exist?
abort("Error: #{options[:private]} is not present in this directory.  Use -p or --private to specify another private input file.") unless File.exist?( options[:private] ) or options[:web]

# Does the template file exist?
abort("Error: template #{options[:template]} does not exist.  Use -t or --template to specify another template file.") unless File.exist?( options[:template] )

input_basename, input_extension = options[:input].split('.')
template_basename, template_extension1, template_extension2 = options[:template].split('.')

if options[:web]
  output_file = input_basename + '-web.' + template_extension1
else
  output_file = input_basename + '.' + template_extension1

  # Load and merge contact information (for full resume)
  # private.yml contains contact information I don't want posted
  private = YAML::load( File.open(options[:private]) )
  resume["contact"] = resume["contact"].merge(private["contact"])
end

# Load the escape function and run it on resume hash (if escape function exists)
escape_defn = File.join( File.dirname(__FILE__), 'templates', '/escape_' + template_extension1 + '.rb' )
require escape_defn if File.exist?(escape_defn)
escape(resume) if defined?(escape)

# Load the ERB template
template = ERB.new( File.new(options[:template]).read, trim_mode: "<>" )

namespace = ErbBinding.new resume
result = template.result namespace.send(:get_binding)

# Create 'output' directory if it doesn't exist
Dir.mkdir("output") unless File.exist?("output") && File.directory?("output")

# Write to output file
File.open( 'output/' + output_file, "w" ) do |file|
  file.write result
end
puts "Created #{output_file}"
