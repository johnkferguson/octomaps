PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |conf|
  conf.mock_with :mocha
  conf.include Rack::Test::Methods
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Octomaps::App
#   app Octomaps::App.tap { |a| }
#   app(Octomaps::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
