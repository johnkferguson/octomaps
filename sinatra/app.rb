require 'heroku'
require 'sinatra'
require 'thin'
require 'sinatra/reloader'
require 'pry'

get '/' do
 erb :form 
end
