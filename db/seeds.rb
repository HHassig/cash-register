require "csv"
require "open-uri"

items = []
csv_text = File.read(Rails.root.join('lib','seeds','items.csv'))
csv = CSV.parse(csv_text, encoding: 'UTF-8')
csv.each do |row|
  items << row
end

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
  puts "Saved!"
end
puts Item.first.name
