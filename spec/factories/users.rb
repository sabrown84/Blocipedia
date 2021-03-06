FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'helloworld'
    password_confirmation 'helloworld'
    confirmed_at Time.zone.now
  end
end
