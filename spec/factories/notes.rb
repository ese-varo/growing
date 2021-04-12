FactoryBot.define do
  factory :note do
    description { Faker::Lorem.paragraph }
    association :noteable, factory: :day
  end
end
