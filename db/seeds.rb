# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

checkin_body = <<END
#### Get Done
repair banana stand
find company checkbook

#### Got Done
rocked karaoke with maeby

#### Flags
Y: refrigerator keeps falling through the wall

#### Shelf
get mother into a home
END

User.create(name: "Adam Becker", email: "ad@mbecker.cc", password: "password")
User.create(name: "Tobias Funke", email: "tobias@gobiasindustries.com", password: "password")
User.create(name: "Michael Bluth", email: "michael@bluthco.com", password: "password")

User.all.each do |user|

  date = Date.current

  10.times do
    break if rand(1..5) == 1
    checkin = user.checkins.build body: checkin_body
    checkin.created_at = date.to_time
    checkin.save
    date = date - 1.day
  end

end