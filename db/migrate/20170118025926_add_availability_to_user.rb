class AddAvailabilityToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :availability, :decimal, default: "0.0"
  end
end
