class AddContributionsCountToUser < ActiveRecord::Migration

  def change
    add_column :users, :contributions_count, :integer, default: 0
  end

end
