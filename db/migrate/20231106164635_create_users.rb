class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :login
      t.string :firstname
      t.string :surname
      t.string :middlename
      t.string :passport
      t.date :borndate
      t.string :address

      t.timestamps
    end
  end
end
