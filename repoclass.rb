if development?
  require_relative 'database' 
  DataMapper::Logger.new(STDOUT, :debug)
end

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Repo
  attr_accessor :owner, :name, :locations

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", 
                                         :password => "flatiron001")

  def initialize(owner, name)
    @owner = owner
    @name = name
  end

  def combined_name
    self.owner + "/" + self.name 
  end

  def find_contributors
    # return @contributors if @contributors
    @all_contributors_info ||= @@octokit_client.contribs(self.combined_name) 
    all_contributor_names = @all_contributors_info.collect{|g| g["login"]}
    contributors_in_database = Contributor.all(:login => all_contributor_names)
    contributors_not_in_database = 
      all_contributor_names - contributors_in_database.collect{|c| c.login}
    @contributors = [contributors_in_database]
    if contributors_not_in_database.size > 0
      @contributors << contributors_not_in_database.collect do |u|
        Contributor.save_new_contributor_to_db(u)
        # binding.pry
      end
    end
    @contributors.flatten
  end

  def get_locations
    @locations ||= find_contributors.collect{|c| c.location_lookup}
  end

  def location_count
    @locations.each_with_object(Hash.new(0)) do |location, loc_hash|
      if location == "" || location == nil
        loc_hash["Location Unkown"] += 1
      else
        loc_hash[location] += 1
      end
    end
  end

end

class Contributor
  include DataMapper::Resource

  property :id, Serial            
  property :login, String           
  property :location, String 

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", 
                                         :password => "flatiron001")
  
  def self.save_new_contributor_to_db(login)
    new_instance = self.new
    new_instance.login = login
    new_instance.location = @@octokit_client.user(login)["location"]
    new_instance.save
    new_instance
  end

  def location_lookup
    self.location
  end
end

DataMapper.finalize
DataMapper.auto_upgrade!