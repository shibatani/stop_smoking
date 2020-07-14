class CreateDamages < ActiveRecord::Migration[6.0]
  def change
    create_table :damages do |t|

      t.timestamps
    end
  end
end
