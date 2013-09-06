class RenameGeocodedCityIdToCityId < ActiveRecord::Migration
  
  def change
    rename_column :locations, :geocoded_city_id, :city_id
  end

end
