FactoryGirl.define do
  factory :incident do
    student factory: :student
    user factory: :user
    date_incident Time.zone.now
    description Faker::Lorem.paragraph
    soluction Faker::Lorem.paragraph
  end
end
