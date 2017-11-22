# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all

a = User.create!(email: 'lmauricio12@gmail.com')
b = User.create!(email: 'bhiggins033@gmail.com')
c = User.create!(email: 'aacademy.io@gmail.com')

ShortenedURL.destroy_all

url1 = ShortenedURL.create!(user_id: a.id, short_url: 'www.google.com/abc', long_url: 'www.google.com/askjdn/sdkjnasd')
url2 = ShortenedURL.create!(user_id: b.id, short_url: 'www.google.com/def', long_url: 'www.google.com/fhdfh/appacademy')
url3 = ShortenedURL.create!(user_id: b.id, short_url: 'www.google.com/hij', long_url: 'www.google.com/dffgfg/sdkjnagfhjjsd')


Visit.destroy_all

v1 = Visit.record_visit!(a, url3)
v2 = Visit.record_visit!(b, url1)
v3 = Visit.record_visit!(b, url2)
v4 = Visit.record_visit!(b, url2)
v5 = Visit.record_visit!(b, url2)
v6 = Visit.record_visit!(c, url2)
v7 = Visit.record_visit!(c, url2)
