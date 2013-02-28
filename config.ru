require 'heroku'
require 'sinatra'
require 'thin'
require 'sinatra/reloader'
require 'net/http'
require 'uri'
require 'octokit'
require 'json'
require 'pry'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'google_visualr'
require './repoclass.rb'
require './app.rb'

run Sinatra::Application

