class ChangeDamagesToTops < ActiveRecord::Migration[6.0]
  def change
    rename_table :damages, :tops
  end
end
