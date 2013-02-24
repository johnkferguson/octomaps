#require 'rubygems'
#require './getsprompt.rb'
require 'octokit'
require 'pp'
require 'json'
require 'pry'

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
    @locations ||= contributors.collect{|c| sleep 1 if delay; c.location}
  end
end

class Contributor
  attr_accessor :login, :location

  @@octokit_client = Octokit::Client.new(:login => "flatiron-001", :password => "flatiron001")

  def self.new_from_github_login(login)
    new_instance = self.new
    new_instance.login = login
    new_instance
  end

  def location
    puts ".....looking up location for #{self.login}"
    @location ||= @@octokit_client.user(login)["location"]
    puts ".....found location #{@location} for #{self.login}"
    @location 
  end

end

maps = Repo.new('johnkellyferguson', 'githubmaps')
maps.locations

# octokit = Repo.new('pengwynn', 'octokit')
# octokit.locations