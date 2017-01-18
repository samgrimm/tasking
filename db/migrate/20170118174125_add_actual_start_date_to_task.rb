class AddActualStartDateToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :actual_start_date, :date
  end
end
