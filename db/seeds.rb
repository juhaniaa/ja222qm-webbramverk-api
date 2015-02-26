# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(email: "user1@test.se", password: "123qwe")
u2 = User.create(email: "user2@test.se", password: "123qwe")
u3 = User.create(email: "user3@test.se", password: "123qwe")
u4 = User.create(email: "user4@test.se", password: "123qwe")
u5 = User.create(email: "user5@test.se", password: "123qwe")

u1.apikey = Apikey.create(key: SecureRandom.hex)
u2.apikey = Apikey.create(key: SecureRandom.hex)
u3.apikey = Apikey.create(key: SecureRandom.hex)
u4.apikey = Apikey.create(key: SecureRandom.hex)
u5.apikey = Apikey.create(key: SecureRandom.hex)

Admin.create(email: "admin1@test.se", password: "qwe123")
Admin.create(email: "admin2@test.se", password: "qwe123")
Admin.create(email: "admin3@test.se", password: "qwe123")