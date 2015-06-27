# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.new({
  :name => 'Admin',
  :email => 'admin@admin.com.br',
  :password => '12345678',
  :password_confirmation => '12345678',
  :admin => true,
  :status => true
}).save

p 'Seed students'
for i in (1..100)
  Student.new({
    name: Faker::Name.name,
    responsible: Faker::Name.name,
    contact_responsible: Faker::Internet.email,
    date_enrolment: Time.zone.now - 5.years,
    status: true
  }).save
end

p 'Seed Users'
for i in (1..20)
  User.new({
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678',
    admin: false,
    status: true
  }).save
end

p 'Seed school performace'
for i in (1..100)

  rd = rand(5.years).seconds.ago

  SchoolPerformace.new({
    student_id: rand(1..10),
    user_id: rand(1..9),
    start_date: rd,
    finish_date: rd + 1.month,
    description: Faker::Lorem.paragraph(10)
  }).save
end

p 'Seed incidents'
for i in (1..100)
  Incident.new({
    student_id: rand(1..10),
    user_id: rand(1..9),
    date_incident: rand(10.years).seconds.ago,
    soluction: Faker::Lorem.paragraph(10),
    description: Faker::Lorem.paragraph(10)
  }).save
end
