class AddColumnsToDeal < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :price, :decimal
    add_column :deals, :time, :integer
    add_column :deals, :in_person?, :boolean
  end
end
