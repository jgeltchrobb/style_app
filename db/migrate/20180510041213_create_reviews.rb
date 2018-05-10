class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :profile, foreign_key: true
      t.references :deal, foreign_key: true

      t.timestamps
    end
  end
end
