
#if the home, or root, URL '/' is requested, using the normal GET HTTP method, 
#this renders views/form.erb
#Requests data from a specified resource
#retrieves a representation of a resource
get '/' do
  erb :form     
end

#Submits data to be processed to a specified resource
#sends data to the server, only use when you want to create a new record essentially
post '/' do
  redirect "/map?owner=#{params[:owner]}&repo=#{params[:repo]}"
end


get '/map' do
  @repo = Repo.new(params[:owner], params[:repo])
  @repo.get_locations
  data_table_markers = GoogleVisualr::DataTable.new
  data_table_markers.new_column('string' , 'Location' )
  data_table_markers.new_column('number' , 'Contributions')
  data_table_markers.add_rows(@repo.location_count.count)
  i = 0
  while i < @repo.location_count.count
    @repo.location_count.each do |x|
      if x[0] == nil
        key = "Location Unknown"
      else
        key = x[0]
      end
      value = x[1]
      data_table_markers.set_cell(i,0,key)
      data_table_markers.set_cell(i,1,value)
      i += 1
    end
  end
  opts = { :displayMode => 'markers', :region => 'world', :legend => 'none', :width => 800, :keepAspectRatio => true, :colors => ['FFFAF0', 'FAEBD7']}
  @chart_markers = GoogleVisualr::Interactive::GeoChart.new(data_table_markers, opts)
  erb :map
end

