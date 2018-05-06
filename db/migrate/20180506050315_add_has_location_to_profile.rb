class AddHasLocationToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :has_location, :boolean
  end
end
