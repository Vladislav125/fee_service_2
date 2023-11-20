class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :state_number
      t.string :model
      t.integer :power
      t.string :vehicle_type
      t.date :reg_date
      t.belongs_to :user

      t.timestamps
    end
  end
end
