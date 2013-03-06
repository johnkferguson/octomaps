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

  def locations    
    @locations ||= contributors.collect{|c| c.location_lookup}
  end

    def country_locations    
    @locations ||= contributors.collect{|c| c.location_lookup_countries}
  end

  def combined_name
    self.owner + "/" + self.name 
  end

  def github_contributors
    @github_contributors ||= @@octokit_client.contribs(self.combined_name) 
  end

  def github_contributor_logins
    @github_contributors_logins ||= github_contributors.collect{|g| g["login"]}
  end

  def existing_contributors
    @existing_contributors ||= Contributor.all(:login => github_contributor_logins)
  end

  def existing_contributor_logins
    @existing_contributor_logins ||= existing_contributors.collect{|c| c.login}
  end


  def non_existing_contributor_logins
    @non_existing_contributor_logins ||= github_contributor_logins - existing_contributor_logins
  end

  def contributors 
    if non_existing_contributor_logins.size > 0
      new_contributors = non_existing_contributor_logins.collect do |u|
        Contributor.save_new_contributor_to_db(u)
      end
    end
    [existing_contributors, new_contributors].flatten.compact
    # binding.pry
  end

  def location_count
    locations.each_with_object(Hash.new(0)) do |location, loc_hash|
      if location == "" || location == nil
        loc_hash["Location Unknown"] += 1
      else
        loc_hash[location] += 1
      end
    end
  end

end

class Contributor
  include DataMapper::Resource

  property :id, Serial            
  property :login, String, :index => true    
  property :location, String 
  property :country, String 

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", 
                                         :password => "flatiron001")

  def self.save_new_contributor_to_db(login)
    new_instance = self.new
    new_instance.login = login
    new_instance.location = @@octokit_client.user(login)["location"]
    new_instance.country = country(new_instance.location)
    new_instance.save
    new_instance
  end

  def self.country(location)
    if location.nil?
      "Location Unknown"
    else
      results = Geocoder.search(location)
      geo = results.first
      geo.country
    end
  end

  def location_lookup
    self.location
  end

    def location_lookup_countries
    self.country
  end
end

# DataMapper.finalize
# DataMapper.auto_upgrade!