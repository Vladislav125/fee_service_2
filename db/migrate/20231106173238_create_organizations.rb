class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :org_inn, unique: true, null: false
      t.string :org_kpp, unique: true, null: false
      t.string :address, unique: true, null: false
      t.integer :income, null: false
      t.date :reg_date, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
