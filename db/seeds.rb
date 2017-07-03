User.create! name:  "dao van hung",
 email: "memsenpai@gmail.com",
 password: "123456",
 password_confirmation: "123456",
 admin: true

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password
end

users = User.order(:created_at).take(6)
50.times do |i|
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.microposts.create! content: content, created_at: i.minutes.ago
  end
end
