class RemoveTypeAlbum < ActiveRecord::Migration[5.1]
  def change
    remove_column :albums, :type
    add_column :albums, :live_or_studio, :string, null: false, default: "studio"
  end
end
