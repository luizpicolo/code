FactoryGirl.define do
  factory :incident do
    student { FactoryGirl.create(:student) }
    user { FactoryGirl.create(:user) }
    date_incident Time.zone.now
    description Faker::Lorem.paragraph
    soluction Faker::Lorem.paragraph
  end
end
