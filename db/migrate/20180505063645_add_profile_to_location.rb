class AddProfileToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :profile, foreign_key: true
  end
end
