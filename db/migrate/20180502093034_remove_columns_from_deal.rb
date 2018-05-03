class RemoveColumnsFromDeal < ActiveRecord::Migration[5.2]
  def change
    remove_column :deals, :paid?, :boolean
    remove_column :deals, :stylist_agree?, :boolean
    remove_column :deals, :scrub_agree?, :boolean
  end
end
