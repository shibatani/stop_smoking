class AddPayToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :days, :integer
    add_column :users, :boxes, :integer
  end
end
