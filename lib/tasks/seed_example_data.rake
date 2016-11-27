namespace :code do
  desc "Seed example data for C.O.D.E"
  task seed_example_data: :environment do
    p 'seed students'
    100.times do
      Student.new({
        name: Faker::Name.name,
        responsible: Faker::Name.name,
        contact_responsible: Faker::Internet.email,
        date_enrolment: Time.zone.now - 5.years,
        status: true
      }).save
    end

    p 'seed Users'
    20.times do
      User.new({
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: '12345678',
        password_confirmation: '12345678',
        admin: false,
        status: true
      }).save
    end

    p 'seed Admin'
    User.new({
      name: 'Admin User',
      email: 'admin@admin.com.br',
      password: '12345678',
      password_confirmation: '12345678',
      admin: true,
      status: true
    }).save

    p 'seed school performace'
    100.times do

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
    100.times do
      Incident.new({
        student_id: rand(1..10),
        user_id: rand(1..9),
        date_incident: rand(10.years).seconds.ago,
        soluction: Faker::Lorem.paragraph(10),
        description: Faker::Lorem.paragraph(10)
      }).save
    end
  end
end
