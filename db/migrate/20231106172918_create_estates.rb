class CreateEstates < ActiveRecord::Migration[7.0]
  def change
    create_table :estates do |t|
      t.string :cadastral_number
      t.integer :square
      t.string :address
      t.integer :cost
      t.string :type
      t.date :reg_date

      t.timestamps
    end
  end
end
