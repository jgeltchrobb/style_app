class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :suburb
      t.integer :postcode
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
