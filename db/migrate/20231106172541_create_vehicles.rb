class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :vin, unique: true, null: false
      t.string :state_number, null: false
      t.string :model, null: false
      t.integer :power, null: false
      t.string :vehicle_type, null: false
      t.integer :tax, null: false, default: 0

      t.timestamps
    end
  end
end
