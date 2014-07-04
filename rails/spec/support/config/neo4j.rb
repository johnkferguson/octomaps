module Neo4j
  module RSpecHelpers
    def prepare_database
      close_session
      start_server
      delete_database
    end

    def current_session
      Neo4j::Session.current
    end

    def delete_database
      current_session._query('MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r')
    end

    private

    def close_session
      current_session.close if current_session
    end

    def start_server
      Neo4j::Session.open(:server_db, test_server_url)
    end

    def test_server_url
      ENV['NEO4J_TEST_SERVER_URL'] || 'http://localhost:7474'
    end
  end
end

RSpec.configure do |config|
  config.before(:all) { prepare_database }
  config.before(:each) { prepare_database unless current_session }
  config.after(:each, :neo4j) { delete_database }
end
