FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "sharky#{n}@sharkyfries.com" }
    password "123123123"
    role "member"

    factory :admin do
      after(:create) do |user|
        user.role = "admin"
        user.save
      end
    end
  end
end
