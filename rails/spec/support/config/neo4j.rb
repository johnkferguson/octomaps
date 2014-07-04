RSpec.configure do |config|
  config.before(:all) { prepare_database }
  config.before(:each) { prepare_database unless current_session }
  config.after(:each, :neo4j) { delete_database }
end
