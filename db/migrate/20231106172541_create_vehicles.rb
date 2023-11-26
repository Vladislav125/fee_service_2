class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :state_number, unique: true, null: false
      t.string :model, null: false
      t.integer :power, null: false
      t.string :vehicle_type, null: false
      t.date :reg_date, null: false
      t.integer :tax, null: false, default: 0
      t.boolean :tax_paid, null: false, default: false
      t.belongs_to :user
            
      t.timestamps
    end
  end
end
