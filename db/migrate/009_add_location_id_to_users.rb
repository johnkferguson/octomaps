class AddLocationIdToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :location_id
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :location_id
    end
  end
end
