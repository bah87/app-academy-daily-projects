# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all

cat1 = Cat.create(birth_date: '2010-01-10', color: 'black', name: 'Shadow', sex: 'M', description: 'Lazy')
cat2 = Cat.create(birth_date: '2011-02-20', color: 'orange', name: 'Garfield', sex: 'M', description: 'Likes lasagna')
cat3 = Cat.create(birth_date: '2012-03-30', color: 'white', name: 'Kelly', sex: 'F', description: 'Hyper')
cat4 = Cat.create(birth_date: '2013-04-04', color: 'gray', name: 'Ash', sex: 'F', description: 'Sneaky')
cat5 = Cat.create(birth_date: '2014-05-15', color: 'black', name: 'Fran', sex: 'F')

CatRentalRequest.destroy_all

request1 = CatRentalRequest.create(start_date: '2017-11-28', end_date: '2017-12-28', cat_id: cat1.id)
request2 = CatRentalRequest.create(start_date: '2017-11-29', end_date: '2017-12-27', cat_id: cat2.id)
request3 = CatRentalRequest.create(start_date: '2017-11-30', end_date: '2017-12-26', cat_id: cat3.id)
request4 = CatRentalRequest.create(start_date: '2017-12-01', end_date: '2017-12-25', cat_id: cat2.id)
request5 = CatRentalRequest.create(start_date: '2017-12-29', end_date: '2018-01-29', cat_id: cat5.id)
