require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'simplecov'
SimpleCov.start

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../test/dummy/config/environment.rb', __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../test/dummy/db/migrate', __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
Minitest::Reporters.use!

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end

# require 'webmock/minitest'
# MinitestVcr::Spec.configure!

# require 'vcr'
# VCR.configure do |c|
#   c.cassette_library_dir = File.expand_path('../../test/cassettes', __FILE__)
#   # c.configure_rspec_metadata!
#   c.hook_into :webmock
#   c.ignore_localhost = false
#   c.default_cassette_options = { record: :once, match_requests_on: [:method, :host, :path] }
#   c.allow_http_connections_when_no_cassette = false
#   c.debug_logger = File.open(File.join(File.expand_path('../../test/cassettes', __FILE__), 'letsencrypt.log'), 'w')
# end

require 'mocha/mini_test'
