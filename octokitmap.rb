require 'rubygems'
require 'octokit'
require 'pp'
require 'json'

john = Octokit.user("JohnKellyFerguson")

#the output of location is a string
location = john.fetch("location")

puts location
