class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.integer :user_id
      t.integer :repository_id
      t.timestamps
    end
  end

  def self.down
    drop_table :contributions
  end
end
