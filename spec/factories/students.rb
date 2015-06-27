FactoryGirl.define do
  factory :student do
    name Faker::Name.name
    responsible Faker::Name.name
    contact_responsible Faker::Internet.email
    date_enrolment Time.zone.now - 3.month
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'assets', 'example.jpg')) }
    status true
  end
end
