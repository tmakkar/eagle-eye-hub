require 'faker'

5.times do
  Category.create!(name: Faker::Commerce.department)
end

20.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price,
    stock_quantity: rand(1..100),
    category: Category.all.sample
  )
end

require 'open-uri'
require 'json'

url = 'https://dummyjson.com/products'
data = JSON.parse(URI.open(url).read)

data["products"].each do |item|
  category = Category.find_or_create_by!(name: item["category"])
  Product.create!(
    name: item["title"],
    description: item["description"],
    price: item["price"],
    stock_quantity: item["stock"],
    category: category
  )
end
