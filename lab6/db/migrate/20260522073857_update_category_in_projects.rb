class UpdateCategoryInProjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :category, :string
    add_reference :projects, :category, foreign_key: true
  end
end
