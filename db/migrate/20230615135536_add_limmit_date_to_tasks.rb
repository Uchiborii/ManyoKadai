class AddLimmitDateToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :limit_date, :date, null: false, default: -> { 'CURRENT_DATE' } 
  end
end
