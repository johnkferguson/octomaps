require 'rubygems'
require 'octokit'
require 'pp'
require 'json'

john = Octokit.user("JohnKellyFerguson")

#location is a string
location = john.fetch("location")

puts location
