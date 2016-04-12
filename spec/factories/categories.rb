FactoryGirl.define do
  factory :category do
    name "Living room"
    initialize_with { Category.find_or_create_by(name: name) }
  end
end
