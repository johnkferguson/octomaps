 class RenameGeocodedCityToCity < ActiveRecord::Migration
  def change
    rename_table :geocoded_cities, :cities
  end

end
