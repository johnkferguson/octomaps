class CreateGeocodedCities < ActiveRecord::Migration
  def self.up
    create_table :geocoded_cities do |t|
      t.string :name
      t.integer :geocoded_country_id
      t.timestamps
    end
  end

  def self.down
    drop_table :geocoded_cities
  end
end
