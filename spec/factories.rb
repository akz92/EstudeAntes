FactoryGirl.define do
  factory :period do
    start_date Faker::Date.backward(90)
    end_date Faker::Date.forward(90)
    number Faker::Number.number(1)
    user_id Faker::Number.number(1)
    is_current 'true'
    id Faker::Number.number(1)
  end

  factory :event do
    start_date '10-08-2015'
    end_date '20-08-2015'
    start_time '10:00'
    end_time '12:00'
    title Faker::Name.name[0..14]
    every 'week'
    subject_id Faker::Number.number(1)
  end

  factory :test do
    date Faker::Date.forward(90)
    subject_id Faker::Number.number(1)
    value Faker::Number.between(10, 30)
    grade Faker::Number.between(0,10)
  end

  factory :subject do
    name Faker::Name.name[0..14]
    period_id Faker::Number.number(1)
    id Faker::Number.number(1)
  end

  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password(8)
    id Faker::Number.number(1)
  end
end
