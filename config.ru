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
require 'google_visualr'

require './repoclass'
require './app'


# binding.pry
run Sinatra::Application