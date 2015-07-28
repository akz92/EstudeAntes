require 'faker'

FactoryGirl.define do
  factory :event do |f|
    f.start_date { Faker::Date }
    f.end_date { Faker::Date }
    f.start_time { Faker::Time }
    f.end_time { Faker::Time }
  end
end
