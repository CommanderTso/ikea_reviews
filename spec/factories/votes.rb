FactoryGirl.define do
  factory :vote, aliases: [:upvote] do
    user :user
    review :review
    score 1

    factory :downvote do
      user :user
      review :review
      score -1
    end
  end
end
