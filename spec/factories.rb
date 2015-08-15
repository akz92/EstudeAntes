FactoryGirl.define do
  factory :period do
    start_date (Date.today - 7) 
    end_date (Date.today + 7)
    number 1
    user_id 1
    is_current 'false'
    id 1
  end

  factory :event do
    start_date '10-08-2015'
    end_date '20-08-2015'
    start_time '10:00'
    end_time '12:00'
    title 'Math'
    every 'week'
    subject_id 1
  end

  factory :test do
    date '01-01-2015'
    subject_id 1
    value 10
    grade 8
  end

  factory :subject do
    name 'Math'
    period_id 1
  end

  factory :user do
    id 1
    email 'user@example.com'
    password '12345678'
  end
end
