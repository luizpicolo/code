FactoryGirl.define do
  factory :user do
    pwd = Faker::Internet.password
    name Faker::Name.name
    email Faker::Internet.email
    password pwd
    password_confirmation pwd
    admin true
    status true
  end
end
