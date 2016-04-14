FactoryGirl.define do
  factory :item, aliases: [:item_1] do
    title "EKTORP"
    subtitle "Footstool, Nordvalla light blue"
    item_url "http://www.ikea.com/us/en/catalog/products/S99129122/"
    picture_url "http://www.ikea.com/us/en/images/products/ektorp-footstool-blue__0386202_PE559152_S4.JPG"
    price "149.00"
    category

    factory :item_2 do
      title "HEMNES"
      subtitle "Coffee table, black-brown"
      item_url "http://www.ikea.com/us/en/catalog/products/80176284/"
      picture_url "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG"
      price "139.00"
      category

      factory :item_with_100_reviews do
        after(:create) do |item|
          25.times do
            create(:review, rating: 3, item: item)
            create(:review, rating: 4, item: item)
            create(:review, rating: 5, item: item)
            create(:review, rating: 2, item: item)
          end
        end
      end
    end

    factory :item_3 do
      title "ALÄNG"
      subtitle "Ceiling lamp, white"
      item_url "http://www.ikea.com/us/en/catalog/products/00176042/"
      picture_url "http://www.ikea.com/us/en/images/products/alang-ceiling-lamp-white__0120130_PE276557_S4.JPG"
      price "29.99"
      category
    end

    factory :item_4 do
      title "TILLFÄLLE"
      subtitle "Coffee table, eucalyptus, black/white"
      item_url "http://www.ikea.com/us/en/catalog/products/10311964/"
      picture_url "http://www.ikea.com/us/en/images/products/tillfalle-coffee-table-assorted-colors__0374748_PE552974_S4.JPG"
      price "119.00"
      category
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
