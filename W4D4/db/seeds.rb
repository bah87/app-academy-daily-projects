# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
u1 = User.create(email: 'user1', password: '111111')
u2 = User.create(email: 'user2', password: '222222')
u3 = User.create(email: 'user3', password: '333333')

Band.destroy_all
b1 = Band.create(user_id: u1.id, name: 'U2')
b2 = Band.create(user_id: u1.id, name: 'Mumford & Sons')
b3 = Band.create(user_id: u1.id, name: 'Kiss')
b4 = Band.create(user_id: u2.id, name: 'Radiohead')
b5 = Band.create(user_id: u2.id, name: 'NSYNC')
b6 = Band.create(user_id: u3.id, name: 'The Doors')

Album.destroy_all
a1 = Album.create(title: 'album1', year: 2000, live_or_studio: "live", band_id: b1.id)
a2 = Album.create(title: 'album2', year: 2000, live_or_studio: "studio", band_id: b1.id)
a3 = Album.create(title: 'album1', year: 2000, live_or_studio: "live", band_id: b2.id)
a4 = Album.create(title: 'album2', year: 2000, live_or_studio: "studio", band_id: b2.id)
a5 = Album.create(title: 'album1', year: 2000, live_or_studio: "live", band_id: b3.id)
a6 = Album.create(title: 'album2', year: 2000, live_or_studio: "studio", band_id: b3.id)
a7 = Album.create(title: 'album1', year: 2000, live_or_studio: "live", band_id: b4.id)
a8 = Album.create(title: 'album2', year: 2000, live_or_studio: "studio", band_id: b4.id)
a9 = Album.create(title: 'album1', year: 2000, live_or_studio: "live", band_id: b5.id)
a10 = Album.create(title: 'album2', year: 2000, live_or_studio: "studio", band_id: b5.id)
a11 = Album.create(title: 'album1', year: 2000, live_or_studio: "live", band_id: b6.id)
a12 = Album.create(title: 'album2', year: 2000, live_or_studio: "studio", band_id: b6.id)