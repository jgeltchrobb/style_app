class AddUserRoleToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :user_role, :string
  end
end
