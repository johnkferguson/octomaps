class Map
  COUNTRY_OPTIONS = { :displayMode => 'region',
                      :region => 'world',
                      :legend => 'none',
                      :colors => ['FF8F86', 'C43512'] }

  CITY_OPTIONS = { :displayMode => 'markers',
                   :region => 'world',
                   :legend => 'none',
                   :colors => ['FF8F86', 'C43512'] }

  attr_reader :repository, :type

  def initialize(repository, params)
    @repository = repository
    @type = determine_type_based_upon(params)
  end

  def repository_name
    repository.full_name
  end

  def contributions_count
    repository.contributions_count
  end

  def number_of_locations
    location_count_hash.size
  end

  def is_of_cities?
    type == "city"
  end

  def is_of_countries?
    type == "country"
  end

  def sorted_list
    location_count_hash.sort_by  { |location, contributors| contributors }.reverse
  end

  def google_visualr_chart_markers
    GoogleVisualr::Interactive::GeoChart.new(markers, options_based_upon_type)
  end

  private

    def determine_type_based_upon(params)
      if params["city"]
        "city"
      elsif params["country"]
        "country"
      end
    end

    def location_count_hash
      if type == "city"
        city_count_hash
      elsif type == "country"
        country_count_hash
      end
    end

    [:country, :city].each do |type_of_location|
      define_method("#{type_of_location}_count_hash") do
        repository.users.each_with_object(Hash.new(0)) do |user, hash|
          if user.send("has_no_#{type_of_location}?".to_sym)
            hash["Location Unknown"] += 1
          else
            hash[user.send("#{type_of_location}_name".to_sym)] +=1
          end
        end
      end
    end

    def markers
      data_table_markers = GoogleVisualr::DataTable.new
      data_table_markers.new_column('string' , 'Location' )
      data_table_markers.new_column('number' , 'Contributors')
      data_table_markers.add_rows(number_of_locations)
      i = 0
      location_count_hash.each do |location, count|
        unless location == "Location Unknown"
          data_table_markers.set_cell(i,0,location)
          data_table_markers.set_cell(i,1, count)
          i += 1
        end
      end
      data_table_markers
    end

    def options_based_upon_type
      if type == "city"
        CITY_OPTIONS
      elsif type == "country"
        COUNTRY_OPTIONS
      end
    end

end