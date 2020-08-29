class SmokerRecords < ActiveRecord::Migration[6.0]
  def change
    drop_table :smokers
  end
end
