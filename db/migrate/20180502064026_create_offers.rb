class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.decimal :price
      t.integer :time
      t.boolean :in_person?
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
