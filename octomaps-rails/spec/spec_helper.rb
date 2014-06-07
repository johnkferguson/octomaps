# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.include Neo4jDatabaseHelpers
  config.infer_base_class_for_anonymous_controllers = false

  config.before(:all) do
    prepare_database
  end

  config.before(:each) do
    prepare_database unless current_session
  end
end
