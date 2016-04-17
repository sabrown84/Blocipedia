# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

4.times do
   user = User.new(
     email: Faker::Internet.email,
     password: Faker::Lorem.characters(10)
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all

 15.times do
   Wiki.create!(
     user: users.sample,
     title: Faker::Lorem.sentence,
     body: Faker::Lorem.paragraph,
     private: false
   )
 end
 wikis = Wiki.all

 user = User.first
 user.skip_reconfirmation!
 user.update_attributes!(
   email: 'goinghome@forest.com',
   password: 'helloworld',
   role: 'admin'
 )

	user = User.second
	user.skip_reconfirmation!
  user.update_attributes!(
   email: 'premium@example.com',
   password: 'worldclass',
   role: 'premium'
 )

 user = User.third
 user.skip_reconfirmation!
 user.update_attributes!(
   email: 'standard@example.com',
   password: 'worldgame',
   role: 'standard',
 )

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
