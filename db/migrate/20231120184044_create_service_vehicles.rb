class CreateServiceVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :service_vehicles do |t|
      t.string :state_number, unique: true, null: false
      t.string :model, null: false
      t.integer :power, null: false
      t.string :vehicle_type, null: false
      t.date :reg_date, null: false
      t.integer :tax, null: false, default: 0
      t.boolean :tax_paid, default: false
      t.belongs_to :organization

      t.timestamps
    end
  end
end
