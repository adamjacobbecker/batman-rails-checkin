# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

def checkin_body(project_name)
"
#### Get Done
repair banana stand for #{project_name}
find company checkbook

#### Got Done
rocked karaoke with maeby

#### Flags
Y: refrigerator keeps falling through the wall

#### Shelf
get mother into a home
"
end

User.create(name: "Adam Becker", email: "ad@mbecker.cc", login: "ajb")
User.create(name: "Tobias Funke", email: "tobias@gobiasindustries.com", login: "analrapist")
User.create(name: "Michael Bluth", email: "michael@bluthco.com", login: "mbluth")

Project.create(name: "Bluth Company")
Project.create(name: "Gobias Industries")

Project.all.each do |project|
  project.users << User.all

  User.all.each do |user|

    date = Date.current

    10.times do
      break if rand(1..5) == 1
      checkin = user.checkins.build body: checkin_body(project.name)
      checkin.project_id = project.id
      checkin.created_at = date.to_time
      checkin.save
      date = date - 1.day
    end

  end
end

