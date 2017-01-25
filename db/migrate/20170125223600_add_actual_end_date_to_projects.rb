class AddActualEndDateToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :actual_end_date, :date
  end
end
