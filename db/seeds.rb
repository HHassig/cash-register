require "csv"
require "open-uri"

# Import csv seed
items = []
csv_text = File.read(Rails.root.join('lib','seeds','items.csv'))
csv = CSV.parse(csv_text, encoding: 'UTF-8')
csv.each do |row|
  items << row
end

# Add items to DB
items.each do |item|
  add_item = Item.new(
    product_code: item[0],
    name: item[1],
    description: item[2],
    brand: item[3],
    currency: item[4],
    price: item[5],
    category: item[6],
    inventory_remaining: item[7],
    photo: item[8]
  )
  add_item.save!
  puts "#{item[0]} saved"
end

# Create normal and admin user
User.create!(email: "admin@test.com",
            password: "123456",
            admin: true)

User.create!(email: "user@test.com",
            password: "123456",
            admin: false)
puts "Users saved!"

# Create promos from specsheet
Promotion.create!(item_id: 3,
                  min_quantity: 3,
                  kind: "bulk",
                  name: "COO Strawberries",
                  active: true,
                  promo_price: 4.5)

Promotion.create!(item_id: 2,
                  min_quantity: 3,
                  kind: "bulk",
                  name: "Coffee Addiction",
                  active: true,
                  promo_price: (11.23 * 2 / 3))

Promotion.create!(item_id: 1,
                  kind: "bogo",
                  name: "CEO ❤️ GT",
                  active: true,
                  min_quantity: 2,
                  promo_price: 3.11 / 2)
puts "Promotions saved!"
