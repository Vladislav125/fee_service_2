class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :passport
      t.string :surname
      t.string :firstname
      t.string :middlename
      t.date :born_date
      t.string :address
      t.boolean :admin
      t.boolean :inspector

      t.timestamps
    end
  end
end
