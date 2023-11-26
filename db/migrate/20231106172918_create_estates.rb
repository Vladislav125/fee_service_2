class CreateEstates < ActiveRecord::Migration[7.0]
  def change
    create_table :estates do |t|
      t.string :cadastral_number, unique: true, null: false
      t.integer :square, null: false
      t.string :address, unique: true, null: false
      t.integer :cost, null: false
      t.string :estate_type, null: false
      t.date :reg_date, null: false
      t.integer :tax, null: false, default: 0
      t.boolean :tax_paid, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
