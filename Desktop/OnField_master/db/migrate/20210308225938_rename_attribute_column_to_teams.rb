class RenameAttributeColumnToTeams < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :attribute, :team_level
  end
end
