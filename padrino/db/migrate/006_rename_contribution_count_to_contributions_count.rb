class RenameContributionCountToContributionsCount < ActiveRecord::Migration
  def change
    rename_column :repositories, :contribution_count, :contributions_count
  end

end
