require 'rubygems'
require 'octokit'
require 'pp'
require 'json'

#Gets the location of any user passed in as a parameter:
#ISSUES:
#1. The input must be in the form of a string.
#2. If the user has no location key, the following error is returned:
#KeyError: key not found: "location"

def user_loc(name)
  id = Octokit.user(name)
  location = id.fetch("location")
  location
end