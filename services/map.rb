class Map
  attr_reader :locations_and_count

  def initialize(locations_and_count)
    @locations_and_count = locations_and_count
  end

  def markers
      data_table_markers = GoogleVisualr::DataTable.new
      data_table_markers.new_column('string' , 'Location' )
      data_table_markers.new_column('number' , 'Contributors')
      data_table_markers.add_rows(locations_and_count.size)
      i = 0
      locations_and_count.each do |location, count|
        unless location == "Location Unknown"
          data_table_markers.set_cell(i,0,location)
          data_table_markers.set_cell(i,1, count)
          i += 1
        end
      end
      data_table_markers
    end
end