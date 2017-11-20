class CreateTodoLists < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_lists do |t|      
      t.string :title
      t.text :description 
      t.date  :due_date
      t.string :file_location
      t.timestamps
    end
  end
end
