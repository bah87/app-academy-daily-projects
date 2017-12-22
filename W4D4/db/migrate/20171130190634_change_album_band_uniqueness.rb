class ChangeAlbumBandUniqueness < ActiveRecord::Migration[5.1]
  def change
    remove_index :albums, name: "index_albums_on_band_id"
    add_index :albums, :band_id
  end
end
