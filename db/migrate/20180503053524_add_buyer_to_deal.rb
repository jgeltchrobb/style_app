class AddBuyerToDeal < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :buyer, :integer
  end
end
