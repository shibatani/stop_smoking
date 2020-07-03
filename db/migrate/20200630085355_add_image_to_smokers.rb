class AddImageToSmokers < ActiveRecord::Migration[6.0]
  def change
    add_column :smokers, :image, :string
  end
end
