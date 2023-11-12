class AddFlagsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :inspector, :boolean
    add_column :users, :admin, :boolean
  end
end
