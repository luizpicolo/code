FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    pwd = Faker::Internet.password
    name Faker::Name.name
    password pwd
    password_confirmation pwd
    admin true
    status true
  end

  factory :confirmed_user, parent: :user do
    after(:create) { |user| user.confirm! }
  end
end
