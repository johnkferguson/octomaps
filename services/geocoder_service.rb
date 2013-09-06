class GeocoderService
  attr_reader :location, :location_name, :results, :country, :city

  def initialize(location)
    @location = location
    @location_name = location.name
    @results = Geocoder.search(location_name)
    if results.first
      @country = results.first.country
      @city = results.first.formatted_address
    end
  end

  def geocode_location
    found_city = GeocodedCity.find_or_create_by_name(city)
    found_country = GeocodedCountry.find_or_create_by_name(country)
    location.geocoded_city = found_city
    found_city.geocoded_country = found_country
    found_city.save!
  end

end