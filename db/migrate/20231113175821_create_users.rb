class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :snils, null: false, unique: true
      t.string :inn, null: false, unique: true
      t.string :ipid, unique: true, default: nil
      t.string :password_digest
      t.string :passport, null: false, unique: true
      t.string :surname, null: false
      t.string :firstname, null: false
      t.string :middlename
      t.date :born_date, null: false
      t.string :address, null: false
      t.integer :income, default: 0, null: false
      t.boolean :admin, default: false
      t.boolean :inspector, default: false
      t.string :remember_digest

      t.timestamps
    end
  end
end
