#!/usr/bin/env ruby
require_relative './config'

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ./deploy.rb <template-name> --region <aws region>"
  opts.on('--region REGION', 'Specify the AWS region') do |region|
    options[:region] = region
  end
end.parse!

template_name = ARGV.shift

unless options.key?(:region)
  print "Missing --region option. Please specify the AWS region."
  exit 1
end

puts "\nTransforming ERB to YAML for template '#{template_name}'..."
`erb aws_region=#{options[:region]} -T - -r ./config.rb  #{template_file}.erb > #{template_name}.yml `
`erb -T - -r ./config.rb #{template_file} > #{template_name}.yml`
if $?&.exitstatus == 0
  puts "Success!"
else
  puts "Error: Failed to transform ERB to YAML."
end
