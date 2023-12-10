class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :snils, null: true, unique: true
      t.string :inn, null: false, unique: true
      t.string :kpp, null: true, unique: true
      t.string :ipid, unique: true, default: nil
      t.string :password_digest
      t.string :passport, null: true, unique: true
      t.string :surname, null: true
      t.string :firstname, null: false
      t.string :middlename, null: true
      t.date :born_date, null: false
      t.string :address, null: false
      t.integer :income, default: 0, null: false
      t.integer :balance, default: 0, null: false
      t.boolean :admin, default: false
      t.boolean :inspector, default: false
      t.boolean :organization, default: false
      t.string :remember_digest

      t.belongs_to :user, null: true

      t.timestamps
    end
  end
end
