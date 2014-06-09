RSpec.configure do |config|
  config.before(:all) do
    prepare_database
  end

  config.before(:each) do
    prepare_database unless current_session
  end

  config.after(:each, :neo4j) do
    delete_database
  end
end

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
  Neo4j::Session.open(:server_db, 'http://localhost:7474')
end
