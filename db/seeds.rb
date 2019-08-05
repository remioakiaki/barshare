# frozen_string_literal: true

User.create!(name: 'テストユーザー',
             email: 'test@test.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true)

29.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'

  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
