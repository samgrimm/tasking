class AddTimeTrackerToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :time_tracker, :datetime
  end
end
