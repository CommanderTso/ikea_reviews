FactoryGirl.define do
  factory :item, aliases: [:item_1] do
    title "EKTORP"
    subtitle "Footstool, Nordvalla light blue"
    item_url "http://www.ikea.com/us/en/catalog/products/S99129122/"
    picture_url "http://www.ikea.com/us/en/images/products/ektorp-footstool-blue__0386202_PE559152_S4.JPG"
    price "149.00"

    factory :item_2 do
      title "HEMNES"
      subtitle "Coffee table, black-brown"
      item_url "http://www.ikea.com/us/en/catalog/products/80176284/"
      picture_url "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG"
      price "139.00"
    end

    factory :item_with_3_reviews do
      after(:create) do |item|
        create(:review, rating: 3, item: item)
        create(:review, rating: 5, item: item)
        create(:review, rating: 2, item: item)
      end
    end
  end
end
