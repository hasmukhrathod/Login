# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name:  "Thinkbiz",
             last_name: "Industry",
             email: "hasmukh@thinkbiz.co.in",
             password:              "123",
             password_confirmation: "123",
             admin: true)


99.times do |n|
  name1  = Faker::Name.name
  name2  = Faker::Name.name
  email = "example-#{n+1}@thinkbiz.co.in"
  password = "password"
  User.create!(first_name:  name1,
               last_name: name2,
               email: email,
               password: password,
               password_confirmation: password)
end