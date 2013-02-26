#db location must be changed to reflect Mac username
ENV['DATABASE_URL'] ||= 'postgres://John:@localhost/octomaps'

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

  def contributors
    puts "looking up contributors for #{self.combined_name}"
    @github_contributors ||= @@octokit_client.contribs(self.combined_name)
    # delay = true if @github_contributors.size > 10
 
    puts "...found #{@github_contributors.size} contributors"
    @contributors ||= @github_contributors.collect do |u| 
      # sleep 2 if delay
      Contributor.new_from_github_login(u["login"])
    end
  end

  def locations
    delay = true if contributors.size > 20
    @locations ||= contributors.collect{|c| sleep 1 if delay; c.location_lookup}
  end

  # def location_count
  #   @locations.each_with_object(Hash.new(0)) do |location, hash|
  #     hash[location] += 1
  #   end
  # end

end

class Contributor
  include DataMapper::Resource
  # attr_accessor :login, :location

  property :id, Serial            # Auto-increment integer id
  property :login, Text           # Does this refer to the attr accessor defined here?
  property :location, Text        # Does this refer to the attr accessor defined here?

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", :password => "flatiron001")

  def self.new_from_github_login(login)
    new_instance = self.new
    new_instance.login = login
    new_instance
  end

  def location_lookup
    puts ".....looking up location for #{self.login}"
    self.location ||= @@octokit_client.user(login)["location"]
    puts ".....found location #{@location} for #{self.login}"
    self.location
    Contributor.first_or_create({:login => @login, :location => @location})
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!

maps = Repo.new('johnkellyferguson', 'githubmaps')
maps.locations

# octokit = Repo.new('pengwynn', 'octokit')
# octokit.locations