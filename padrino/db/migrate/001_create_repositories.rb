class CreateRepositories < ActiveRecord::Migration
  def self.up
    create_table :repositories do |t|
      t.string :full_name
      t.string :description
      t.string :html_url
      t.timestamps
    end
  end

  def self.down
    drop_table :repositories
  end
end
