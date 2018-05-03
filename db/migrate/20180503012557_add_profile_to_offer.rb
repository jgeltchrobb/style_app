class AddProfileToOffer < ActiveRecord::Migration[5.2]
  def change
    add_reference :offers, :profile, foreign_key: true
  end
end
