class RenameGeocodedCountryToCountry < ActiveRecord::Migration
  def change
    rename_table :geocoded_countries, :countries
  end
end
