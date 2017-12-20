json.pokemon do
  json.id @pokemon.id
  json.name @pokemon.name
  json.attack @pokemon.attack
  json.defense @pokemon.defense
  json.image_url asset_path(@pokemon.image_url)
  json.moves @pokemon.moves
  json.poke_type @pokemon.poke_type
end

json.items @pokemon.items.each do |item|
  json.extract! item, :id, :name, :pokemon_id, :price, :happiness
  json.image_url asset_path(item.image_url)
end
