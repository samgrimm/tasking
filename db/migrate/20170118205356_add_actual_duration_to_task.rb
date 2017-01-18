class AddActualDurationToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :actual_duration, :decimal, default: "0.0"
  end
end
