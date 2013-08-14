class ChangeGravatarNameToGravatarId < ActiveRecord::Migration

  def change
    rename_column :users, :gravatar_name, :gravatar_id
  end

end
