FactoryGirl.define do
  factory :review do
    rating 3
    sequence(:description) { |n| "I laughed, I cried, it was better than Cats. (#{n})" }
    item
    user
  end
end
