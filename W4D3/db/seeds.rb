# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

owner1 = User.create(username: 'Scott', password: '111111')
owner2 = User.create(username: 'Brendan', password: '222222')
owner3 = User.create(username: 'George', password: '333333')

Cat.destroy_all

cat1 = Cat.create(owner_id: owner1.id, birth_date: '2010-01-10', color: 'black', name: 'Shadow', sex: 'M', description: 'Lazy')
cat2 = Cat.create(owner_id: owner1.id, birth_date: '2011-02-20', color: 'orange', name: 'Garfield', sex: 'M', description: 'Likes lasagna')
cat3 = Cat.create(owner_id: owner2.id, birth_date: '2012-03-30', color: 'white', name: 'Harper', sex: 'F', description: 'Hyper')
cat4 = Cat.create(owner_id: owner3.id, birth_date: '2013-04-04', color: 'gray', name: 'Ash', sex: 'F', description: 'Sneaky')
cat5 = Cat.create(owner_id: owner3.id, birth_date: '2014-05-15', color: 'black', name: 'Fran', sex: 'F')

CatRentalRequest.destroy_all

request1 = CatRentalRequest.create(user_id: owner2.id, start_date: '2017-11-28', end_date: '2017-12-28', cat_id: cat1.id)
request2 = CatRentalRequest.create(user_id: owner2.id, start_date: '2017-11-29', end_date: '2017-12-27', cat_id: cat2.id)
request3 = CatRentalRequest.create(user_id: owner3.id, start_date: '2017-11-30', end_date: '2017-12-26', cat_id: cat3.id)
request4 = CatRentalRequest.create(user_id: owner1.id, start_date: '2017-12-01', end_date: '2017-12-25', cat_id: cat2.id)
request5 = CatRentalRequest.create(user_id: owner1.id, start_date: '2017-12-29', end_date: '2018-01-29', cat_id: cat5.id)
request6 = CatRentalRequest.create(user_id: owner1.id, start_date: '2018-01-03', end_date: '2018-02-01', cat_id: cat4.id)


