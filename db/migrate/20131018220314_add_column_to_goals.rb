class AddColumnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :status, :string
    change_column :goals, :status, :string, :null => false
  end
end
