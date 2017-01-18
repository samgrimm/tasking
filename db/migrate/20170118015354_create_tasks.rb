class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.date :estimated_start_date
      t.references :project, foreign_key: true
      t.decimal :duration, default: "0.0"
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
