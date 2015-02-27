
### Users

u1 = User.create(email: "user1@test.se", password: "123qwe")
u2 = User.create(email: "user2@test.se", password: "123qwe")
u3 = User.create(email: "user3@test.se", password: "123qwe")
u4 = User.create(email: "user4@test.se", password: "123qwe")
u5 = User.create(email: "user5@test.se", password: "123qwe")

### Keys

u1.apikey = Apikey.create(key: SecureRandom.hex)
u2.apikey = Apikey.create(key: SecureRandom.hex)
u3.apikey = Apikey.create(key: SecureRandom.hex)
u4.apikey = Apikey.create(key: SecureRandom.hex)
u5.apikey = Apikey.create(key: SecureRandom.hex)

### Admins

Admin.create(email: "admin1@test.se", password: "qwe123")
Admin.create(email: "admin2@test.se", password: "qwe123")
Admin.create(email: "admin3@test.se", password: "qwe123")

### Hunters

Hunter.create(name: "hunter1")
Hunter.create(name: "hunter2")
Hunter.create(name: "hunter3")
Hunter.create(name: "hunter4")
Hunter.create(name: "hunter5")

### Positions

p1 = Position.create(latitude: 60.119505, longitude: 19.940895)
p2 = Position.create(latitude: 60.101695, longitude: 19.944775)
p3 = Position.create(latitude: 60.241155, longitude: 19.544945)
p4 = Position.create(latitude: 60.395005, longitude: 19.802605)
p5 = Position.create(latitude: 60.207225, longitude: 20.269015)

### Tags

t1 = Tag.create(tagName: "Sweg")
t2 = Tag.create(tagName: "Yolo")
t3 = Tag.create(tagName: "Fishy")
t4 = Tag.create(tagName: "Biggy")
t5 = Tag.create(tagName: "Tiny")

### Events

e1 = Event.create(description: "Finally got it")
e2 = Event.create(description: "My first one")
e3 = Event.create(description: "Woooow!")
e4 = Event.create(description: "Do they even grow this big")
e5 = Event.create(description: "Is this a joke?")

e1.position = p1
e2.position = p2
e3.position = p3
e4.position = p4
e5.position = p5


