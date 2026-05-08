class AddTeamToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :team, :string
  end
end
