class AddStatusAndPriorityToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :integer, nill: false, default: 0
    add_column :tasks, :priority, :integer, nill: false, default: 0
  end
end
