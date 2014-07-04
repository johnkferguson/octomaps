ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
require 'rspec/its'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
  config.include Neo4jHelpers
  config.infer_spec_type_from_file_location!
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end
