item_1 = Item.create(
item_url: "http://www.ikea.com/us/en/catalog/products/80176284/",
title: "HEMNES",
subtitle: "Coffee table, black-brown",
picture_url: "http://www.ikea.com/us/en/images/products/hemnes-coffee-table-brown__0104030_PE250678_S4.JPG",
price: "139.00"
)

item_2 = Item.create(
title: "EKTORP",
subtitle: "Footstool, Nordvalla light blue",
item_url: "http://www.ikea.com/us/en/catalog/products/S99129122/",
picture_url: "http://www.ikea.com/us/en/images/products/ektorp-footstool-blue__0386202_PE559152_S4.JPG",
price: "149.00"
)

user_1 = User.create(email: "abc@gmail.com", password: "12345678")

7.times do
  Review.create(rating: 3, description: "Cool", item: item_1, user: user_1)
  Review.create(rating: 2, description: "Nah", item: item_1, user: user_1)
  Review.create(rating: 1, description: "Awful", item: item_1, user: user_1)
  Review.create(rating: 5, description: "Cool", item: item_1, user: user_1)

  Review.create(rating: 3, description: "Cool", item: item_2, user: user_1)
  Review.create(rating: 2, description: "Nah", item: item_2, user: user_1)
  Review.create(rating: 1, description: "Awful", item: item_2, user: user_1)
  Review.create(rating: 5, description: "Cool", item: item_2, user: user_1)
end
