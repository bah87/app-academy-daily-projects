class EditCatsDescription < ActiveRecord::Migration[5.1]
  def change
    remove_column :cats, :description
    add_column :cats, :description, :text
  end
end
