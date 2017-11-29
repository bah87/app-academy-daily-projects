class UpdateUsersTable < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, name: "index_users_on_username"
    add_index :users, :username, unique: true
    add_index :users, :session_token, unique: true
  end
end
