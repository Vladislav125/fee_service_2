class CreateServiceEstates < ActiveRecord::Migration[7.0]
  def change
    create_table :service_estates do |t|
      t.string :cadastral_number, unique: true, null: false
      t.integer :square, null: false
      t.string :address, unique: true, null: false
      t.integer :cost, null: false
      t.string :estate_type, null: false
      t.date :reg_date, null: false
      t.belongs_to :organization

      t.timestamps
    end
  end
end
