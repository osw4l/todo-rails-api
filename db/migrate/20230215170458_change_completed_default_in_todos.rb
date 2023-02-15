class ChangeCompletedDefaultInTodos < ActiveRecord::Migration[7.0]
  def change
    change_column :todos, :completed, :boolean, default: false
  end
end
