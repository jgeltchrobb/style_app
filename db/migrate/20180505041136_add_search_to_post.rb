class AddSearchToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :search, :string
  end
end
