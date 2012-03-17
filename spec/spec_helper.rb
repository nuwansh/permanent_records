
# Include this file in your test by copying the following line to your test:
#   require File.expand_path(File.dirname(__FILE__) + "/test_helper")

$:.unshift File.expand_path '/../lib',      File.dirname(__FILE__)
$:.unshift File.expand_path '../test_lib', File.dirname(__FILE__)
RAILS_ROOT = File.dirname(__FILE__)

require 'active_record'
require 'active_support'
require 'permanent_records'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/../test_lib/database.yml'))
require 'logger'
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/../test_lib/debug.log")
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite3'])

load 'schema.rb' if File.exist?(File.dirname(__FILE__) + "/../test_lib/schema.rb")

test_support = Dir.glob(File.expand_path '../test_lib/*.rb', File.dirname(__FILE__))
test_support.each do |file|
  autoload File.basename(file).chomp('.rb').camelcase.intern, file
end
test_support.each do |file|
  require file
end

class ActiveSupport::TestCase #:nodoc:
  include ActiveRecord::TestFixtures

  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = false
end
