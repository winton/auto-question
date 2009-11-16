$testing = true
SPEC = File.dirname(__FILE__)
$:.unshift File.expand_path("#{SPEC}/../lib")

require 'rubygems'
require 'auto/require'
require 'pp'

# Manually add this plugin
Auto::Plugins.add File.expand_path("#{SPEC}/../")

# For use with rspec textmate bundle
def debug(object)
  puts "<pre>"
  puts object.pretty_inspect.gsub('<', '&lt;').gsub('>', '&gt;')
  puts "</pre>"
end

Spec::Runner.configure do |config|
end