
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

### Positions for Events

p1 = Position.create(lat: 60.119505, lng: 19.940895)
p2 = Position.create(lat: 60.101695, lng: 19.944775)
p3 = Position.create(lat: 60.241155, lng: 19.544945)
p4 = Position.create(lat: 60.395005, lng: 19.802605)
p5 = Position.create(lat: 60.207225, lng: 20.269015)

### Tags for Events

t1 = Tag.create(tagName: "Sweg")
t2 = Tag.create(tagName: "Yolo")
t3 = Tag.create(tagName: "Fishy")
t4 = Tag.create(tagName: "Biggy")
t5 = Tag.create(tagName: "Tiny")

### Events for Hunters

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

e1.tags << t1
e1.tags << t2
e2.tags << t3
e2.tags << t5
e3.tags << t1
e3.tags << t4
e4.tags << t1
e4.tags << t2
e4.tags << t3
e4.tags << t5

### Hunters

h1 = Hunter.create(name: "hunter1", email: "hunter1@test.se", password: "asd123")
h2 = Hunter.create(name: "hunter2", email: "hunter2@test.se", password: "asd123")
h3 = Hunter.create(name: "hunter3", email: "hunter3@test.se", password: "asd123")
h4 = Hunter.create(name: "hunter4", email: "hunter4@test.se", password: "asd123")
h5 = Hunter.create(name: "hunter5", email: "hunter5@test.se", password: "asd123")

h1.events << e1
h2.events << e2
h3.events << e3
h4.events << e4
h5.events << e5