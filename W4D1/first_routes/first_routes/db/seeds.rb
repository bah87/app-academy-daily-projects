# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
user1 = User.create(username: "Brendan1")
user2 = User.create(username: "Kegan2")
user3 = User.create(username: "Kegan3")

Artwork.destroy_all
artwork1 = Artwork.create(title: "Mona Lisa", image_url: "mona-lisa.com", artist_id: User.first.id)
artwork2 = Artwork.create(title: "Last Supper", image_url: "jayzus.com", artist_id: User.second.id)
artwork3 = Artwork.create(title: "The Screamer", image_url: "AAAAAAA.com", artist_id: User.first.id)

ArtworkShare.destroy_all
aws1 = ArtworkShare.create(artwork_id: Artwork.first.id, viewer_id: User.second.id)
aws2 = ArtworkShare.create(artwork_id: Artwork.second.id, viewer_id: User.first.id)

Comment.destroy_all
c1 = Comment.create(artwork_id: Artwork.first.id, user_id: User.first.id, body: "yoyoyo nice pic")
c2 = Comment.create(artwork_id: Artwork.second.id, user_id: User.second.id, body: "obviously fake")