class AddIndicesToDatabase < ActiveRecord::Migration

  def change
    add_index :repositories, :full_name
    add_index :users, :username
    add_index :locations, :name
    add_index :cities, :name
    add_index :countries, :name
  end
end
