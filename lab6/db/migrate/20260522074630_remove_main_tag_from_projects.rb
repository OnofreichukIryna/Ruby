class RemoveMainTagFromProjects < ActiveRecord::Migration[8.1]
  def change
    remove_column :projects, :main_tag, :string
  end
end
