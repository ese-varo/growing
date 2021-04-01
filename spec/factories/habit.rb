FactoryBot.define do
  factory :habit do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    start_date { Date.today }
    end_date { Faker::Date.forward(days:35) }
    status { false }
    association :user
  end
end
