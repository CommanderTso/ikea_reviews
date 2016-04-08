FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "sharky#{n}@sharkyfries.com" }
    password "blahblahblah"
  end
end
