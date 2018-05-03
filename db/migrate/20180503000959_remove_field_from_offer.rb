class RemoveFieldFromOffer < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :in_person?, :string
  end
end
