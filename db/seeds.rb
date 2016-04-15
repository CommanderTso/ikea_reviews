require 'csv'

category = Category.find_or_create_by(name: "Living room")

item_1 = Item.find_by(item_url: "http://www.ikea.com/us/en/catalog/products/80176284/")
unless item_1.present?
  item_1 = Item.find_or_create_by(
    item_url: "http://www.ikea.com/us/en/catalog/products/80176284/",
    title: "HEMNES",
    subtitle: "Coffee table, black-brown",
    category: category,
    picture_url: "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG",
    price: "139.00"
  )
end

item_2 = Item.find_by(item_url: "http://www.ikea.com/us/en/catalog/products/S99129122/")
unless item_2.present?
  item_2 = Item.find_or_create_by(
    item_url: "http://www.ikea.com/us/en/catalog/products/S99129122/",
    title: "EKTORP",
    subtitle: "Footstool, Nordvalla light blue",
    category: category,
    picture_url: "http://www.ikea.com/us/en/images/products/ektorp-footstool-blue__0386202_PE559152_S4.JPG",
    price: "149.00"
  )
end

user_1 = User.find_by(email: "abc@abc.com")
unless user_1.present?
  user_1 = User.create(email: "abc@abc.com", password: "123123123", password_confirmation: "123123123")
end

user_2 = User.find_by(email: "abcd@gmail.com")
unless user_2.present?
  user_1 = User.create(
    email: "abcd@gmail.com",
    password: "123123123",
    password_confirmation: "123123123",
    role: "admin"
  )
end

7.times do
  Review.find_or_create_by(rating: 3, description: "Cool", item: item_1, user: user_1)
  Review.find_or_create_by(rating: 2, description: "Nah", item: item_1, user: user_1)
  Review.find_or_create_by(rating: 1, description: "Awful", item: item_1, user: user_1)
  Review.find_or_create_by(rating: 5, description: "Cool", item: item_1, user: user_1)

  Review.find_or_create_by(rating: 3, description: "Cool", item: item_2, user: user_1)
  Review.find_or_create_by(rating: 2, description: "Nah", item: item_2, user: user_1)
  Review.find_or_create_by(rating: 1, description: "Awful", item: item_2, user: user_1)
  Review.find_or_create_by(rating: 5, description: "Cool", item: item_2, user: user_1)
end

("U".."Z").to_a.each do |letter|
  array_of_products = CSV.read("db/data/#{letter}.csv")
  array_of_products.each do |row|
    item = Item.new

    item.item_url = row[0],
    item.title = row[1],
    item.subtitle = row[2],
    item.picture_url = row[3],
    item.price = row[4],
    item.article_number = row[6]

    if row[5] == "" then row[5] = "Unknown" end
    item.category = Category.find_or_create_by(name: row[5])

    # if item.title == "VÄRDESÄTTA" then binding.pry end

    if item.save
      puts "Seeded #{item.title} to DB from CSV"
    else
      puts "Skipped #{item.title}"
    end
  end
end
