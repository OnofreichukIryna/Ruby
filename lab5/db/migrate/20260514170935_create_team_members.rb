class CreateTeamMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :role
      t.integer :project_id

      t.timestamps
    end
  end
end
