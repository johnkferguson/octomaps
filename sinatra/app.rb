require 'heroku'
require 'sinatra'
require 'thin'
require 'sinatra/reloader'
require 'pry'
require 'net/http'
require 'uri'
require './repoclass.rb'
# require 'google_chart'
# require 'google_visualr'

#This renders views/form.erb
#Requests data from a specified resource
get '/' do
  erb :form     
end

#Submits data to be processed to a specified resource
post '/' do
  @repo = Repo.new(params[:owner], params[:repo])
  @repo.locations
  @repo.location_count
end
