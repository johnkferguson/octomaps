require 'heroku'
require 'sinatra'
require 'thin'
require 'sinatra/reloader'
require 'pry'
require "net/http"
require 'uri'
require './repoclass.rb'

get '/' do
  erb :form
end

post '/' do
  @repo = Repo.new(params[:owner], params[:repo])
  @repo.locations
end


# name = gets.chomp
# owner = gets.chomp

# uri = URI("http://0.0.0.0:9292/")

# res = Net::HTTP.post_form(uri,{"name"=> name, "owner" => owner})
# # puts res.body
