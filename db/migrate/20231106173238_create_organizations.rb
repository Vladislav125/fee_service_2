class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :org_inn
      t.string :org_kpp
      t.string :address
      t.integer :income

      t.timestamps
    end
  end
end
