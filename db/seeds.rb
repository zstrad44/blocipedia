# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'faker'

20.times do

User.create!(
  email: Faker::Internet.free_email,
  password: Faker::Internet.password(10, 20, true),
  role: Faker::Number.between(0, 1) #=> 7
)
end
users = User.all

10.times do
   Wiki.create!(
     user:   users.sample,
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph(10, true, 8),
     private: true
   )

 end
wikis = Wiki.all

user = User.first
user.update_attributes!(
  email: 'zachstradling@gmail.com',
  password: 'helloworld',
  role: 2
)


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} Wikis created"
