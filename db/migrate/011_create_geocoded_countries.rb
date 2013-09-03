class CreateGeocodedCountries < ActiveRecord::Migration
  def self.up
    create_table :geocoded_countries do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :geocoded_countries
  end
end
