class AddEndDateToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :end_date, :date
  end
end
