class RenameGeocodedCountryIdToCountryId < ActiveRecord::Migration
  
  def change
    rename_column :cities, :geocoded_country_id, :country_id
  end

end
