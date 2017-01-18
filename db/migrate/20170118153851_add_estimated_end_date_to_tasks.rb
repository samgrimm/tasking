class AddEstimatedEndDateToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :estimated_end_date, :date
  end
end
