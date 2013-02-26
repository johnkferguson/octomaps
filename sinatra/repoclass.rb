# take out these require statements once we hook up the database
require 'heroku'
require 'sinatra'
require 'thin'
require 'sinatra/reloader'
require 'pry'
require 'net/http'
require 'uri'
require 'google_charts'
require 'octokit'
require 'pp'
require 'json'
require 'pry'
require 'data_mapper'
require 'dm-postgres-adapter'
# run Sinatra::Application

#db location must be changed to reflect Mac username
ENV['DATABASE_URL'] ||= 'postgres://masharikhter:@localhost/octomaps'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Repo
  attr_accessor :owner, :name, :locations

  @@octokit_client = Octokit::Client.new(:login => "johnkellyferguson", 
    :oauth_token => "a2ee8af1802be1417e4fcc79595fbcc16f67959c")

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

  def get_locations
    @locations ||= contributors.collect{|c| c.location_lookup}
  end

  def location_count
    @locations.each_with_object(Hash.new(0)) do |location, hash|
      hash[location] += 1
    end
  end

end

class Contributor
  include DataMapper::Resource

  property :id, Serial            # Auto-increment integer id
  property :login, Text           # Does this refer to the attr accessor defined here?
  property :location, Text        # Does this refer to the attr accessor defined here?

  @@octokit_client = Octokit::Client.new(:login => "johnkellyferguson", 
    :oauth_token => "a2ee8af1802be1417e4fcc79595fbcc16f67959c")
  
  def self.new_from_github_login(login)
    new_instance = self.new
    new_instance.login = login
    new_instance

    #self.new.tap do |contributor|      #returns the block
    #  contributor.username = username
    #  contributor.load_info_from_github
    #end
  end

  def db_check
    if Contributor.count(:login => @login) == 0
      true
    else 
      false
    end
  end

  def location_lookup
    if db_check == true
      self.location ||= @@octokit_client.user(login)["location"]
      puts ".....looking up location for #{self.login}"
      puts ".....found location #{@location} for #{self.login}"
      self.location
      Contributor.first_or_create({:login => @login, :location => @location})
      @location
      #needs to pass back the location
    elsif db_check == false
      person  = Contributor.first(:login => @login)
      person.location
      #puts "need to pull location from DB"
      #grab the location from the database if the person already exists in the database
    end
  end
end


DataMapper.finalize
DataMapper.auto_upgrade!

# maps = Repo.new('johnkellyferguson', 'githubmaps')
# maps.locations


#rails = Repo.new('rails', 'rails')
#rails.locations

# wang = Repo.new('eewang', 'tickets')
# wang.locations

# octokit = Repo.new('pengwynn', 'octokit')
# octokit.locations