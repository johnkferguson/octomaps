#Gets the location of any user passed in as a parameter:
#ISSUES:
#1. The input must be in the form of a string.
#2. If the user has no location key, the following error is returned:
#KeyError: key not found: "location"

require 'rubygems'
require 'octokit'
require 'pp'
require 'json'

#Ideas rescue key error
def user_loc(name)
  id = Octokit.user(name)
  begin
  location = id.fetch("location")
  rescue
    location = "No location found"
  end
  location
end