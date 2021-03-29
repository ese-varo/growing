FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.safe_email }
    password { Faker::Internet.password }
    password_confirmation { password } 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::Number.number(digits: 10) }
  end
end
