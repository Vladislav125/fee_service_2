class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.text :text_field, null: false
      t.string :preview, null: false
      t.integer :receiver, null: false

      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
