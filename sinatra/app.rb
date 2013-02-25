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
