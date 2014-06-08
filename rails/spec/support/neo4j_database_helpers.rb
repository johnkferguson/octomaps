module Neo4jDatabaseHelpers
  def prepare_database
    close_session
    start_server
    delete_database
  end

  def current_session
    Neo4j::Session.current
  end

  private

  def close_session
    current_session.close if current_session
  end

  def start_server
    Neo4j::Session.open(:server_db, 'http://localhost:7474')
  end

  def delete_database
    Neo4j::Session.current._query('MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r')
  end
end
