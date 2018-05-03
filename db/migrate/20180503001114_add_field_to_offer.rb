class AddFieldToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :in_person, :string
  end
end
