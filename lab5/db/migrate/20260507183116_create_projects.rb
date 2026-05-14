class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :category
      t.string :main_tag
      t.string :client
      t.date :start_date
      t.date :deadline
      t.float :budget
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
