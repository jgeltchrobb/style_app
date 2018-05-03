class AddHasOffersToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :has_offers, :boolean
  end
end
