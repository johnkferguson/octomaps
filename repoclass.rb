#COMMENTS
#Octokit is a gem and module. It has to be included in order to access
#Octokit's methods.
#
#Here's how it works:
#maps = Repo.new
#maps.name = "githubmaps"
#maps.owner = "johnkellyferguson"
#
#maps.combined_name
# >>>will return "johnkellyferguson/githubmaps"
# 
# maps.list_contributors
# >>>will return all contributors to a project
# 
# maps.contributor_locations
# >>>should return all locations of contributors in an array
# 
# I didn't get to test the last part because when I tried running this 
# on 'pengwynn/octocat', I got the following error:
# Octokit::Forbidden: 
# GET 
# https://api.github.com/repos/johnkellyferguson/githubmaps/contributors?anon=false: 
# 403: API Rate Limit Exceeded for 108.46.110.191
# 
# We will have to figure out the api token with octokit
# 
# To-do: 
# 1. create a hash with a key-value pair of username and location
# 2. create a gets prompt that takes input and creates a new instance of the 
# Repo class and sets the repo name = to the input

#require 'rubygems'
#require './getsprompt.rb'
require 'octokit'
require 'pp'
require 'json'

class Repo
  include Octokit

  attr_accessor :owner, :name, :locations, :contributors

  def initialize
    @locations = []
  end

  def combined_name
    self.owner + "/" + self.name 
  end

  def list_contributors
    repo_contribs = Octokit.contribs(self.combined_name)
    @contributors = repo_contribs.collect { |user| user.fetch("login") }
  end

  def find_contributor_locations
    self.list_contributors.each do |name|
      id = Octokit.user(name)
      begin
        @locations << id.fetch("location")
      rescue
        @locations << "Whereabouts Unknown"
      end
    end
  end
end