FactoryGirl.define do
  factory :vote do
    user
    review
    score 0

    factory :downvote do
      user
      review
      score -1
    end

    factory :upvote do
      user
      review
      score 1
    end
  end
end
