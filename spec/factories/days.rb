FactoryBot.define do
  factory :day do
    status { rand(1..100) > 50 }
    date { Faker::Date.forward(days: 1) }
    association :habit
  end
end
