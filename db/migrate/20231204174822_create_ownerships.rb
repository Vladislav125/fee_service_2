class CreateOwnerships < ActiveRecord::Migration[7.0]
  def change
    create_table :ownerships do |t|
      t.date :reg_date, null: false
      t.date :end_date, null: false
      t.integer :tax_sum, default: 0
      t.boolean :paid, default: false
      t.integer :user_id, null: false
      t.integer :vehicle_id, null: true
      t.integer :estate_id, null: true

      t.timestamps
    end
  end
end
