if development?
  require_relative 'database' 
  DataMapper::Logger.new(STDOUT, :debug)
end

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Repo
  attr_accessor :owner, :name, :locations

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", :password => "flatiron001")

  def initialize(owner, name)
    @owner = owner
    @name = name
  end

  def combined_name
    self.owner + "/" + self.name 
  end

  def find_contributors
    return @contributors if @contributors

    # puts "looking up contributors for #{self.combined_name}"
    @github_contributors ||= @@octokit_client.contribs(self.combined_name) 

    github_logins = @github_contributors.collect{|g| g["login"]}

    # take the github logins and split them into two arrays
    # SELECT id, login FROM contributors WHERE login IN (array)
    existing_contributors = Contributor.all(:login => github_logins)
    

    contributors_to_lookup = github_logins - existing_contributors.collect{|c| c.login}
    

    # puts contributors_to_lookup

    # one where we know they already exist in our DB
    # one where we know we need lookups
    @contributors = existing_contributors

    @contributors.inspect

    @contributors << contributors_to_lookup.collect do |u|
      Contributor.new_from_github_login(u)
    end

    

    @contributors.flatten
    # puts "...found #{@github_contributors.size} contributors"
  end

  def get_locations
    @locations ||= find_contributors.collect{|c| c.location_lookup}
  end

  def location_count
    @locations.each_with_object(Hash.new(0)) do |location, hash|
      hash[location] += 1
    end
  end

end

class Contributor
  include DataMapper::Resource

  property :id, Serial            
  property :login, String           
  property :location, String 

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", :password => "flatiron001")
  
  def self.new_from_github_login(login)
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