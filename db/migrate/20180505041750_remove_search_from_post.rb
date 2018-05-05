class RemoveSearchFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :search, :string
  end
end
