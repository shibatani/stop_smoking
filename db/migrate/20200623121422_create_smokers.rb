class CreateSmokers < ActiveRecord::Migration[6.0]
  def change
    create_table :smokers do |t|
      t.string :name
      t.text :word

      t.timestamps
    end
  end
end
