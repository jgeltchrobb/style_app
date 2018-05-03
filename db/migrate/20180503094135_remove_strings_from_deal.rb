class RemoveStringsFromDeal < ActiveRecord::Migration[5.2]
  def change
    remove_column :deals, :stylist_agree, :string
    remove_column :deals, :scrub_agree, :string
    remove_column :deals, :paid, :string
  end
end
