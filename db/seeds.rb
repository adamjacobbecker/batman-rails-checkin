# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(email: "ad@mbecker.cc", password: "password")
User.create(email: "foo@bar.com", password: "foobar")

User.all.each do |u|
  10.times do |i|
    u.checkins.create body: "This is my checkin ##{i}."
  end
end