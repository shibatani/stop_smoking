class AddDaysToSmokers < ActiveRecord::Migration[6.0]
  def change
    add_column :smokers, :days, :integer
  end
end
