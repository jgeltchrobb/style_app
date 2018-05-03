class AddStringsToDeal < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :stylist_agree, :boolean
    add_column :deals, :scrub_agree, :boolean
    add_column :deals, :paid, :boolean
  end
end
