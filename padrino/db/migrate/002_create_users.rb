class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :avatar_url
      t.string :gravatar_name
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
