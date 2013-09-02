class AddContributionCountToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :contribution_count, :integer, default: 0
  end

  #   self.up
  #   change_table :repositories do |t|
  #     t.integer :contribution_count
  #   end
  # end

  # def self.down
  #   change_table :repositories do |t|
  #     t.remove :contribution_count
  #   end
  # end
end
