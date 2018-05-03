class AddChecksToDeal < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :paid?, :string
    add_column :deals, :stylist_agree?, :string
    add_column :deals, :scrub_agree?, :string
  end
end
