#Basic gets prompt to instantiate a new instance of the repo class. Needs to be
#refactored. Currently, the contributor_locations method does not work after
#instantiating this way. It only returns the contributors.

require 'rubygems'
require 'octokit'
require 'pp'
require 'json'
require './repoclass.rb'


print "For which repo do you want to get the location of its users?"
repo_name_input = gets.strip

print "Who is the owner of #{repo_name_input}?"
owner_name_input = gets.strip

repo_name_input = Repo.new(repo_name_input, owner_name_input)