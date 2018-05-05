class AddLocationToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :location, foreign_key: true
  end
end
