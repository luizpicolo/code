FactoryGirl.define do
  factory :school_performace do
    student factory: :student
    user factory: :user
    start_date Time.zone.now
    finish_date Time.zone.now
    description Faker::Lorem.paragraph
  end
end
