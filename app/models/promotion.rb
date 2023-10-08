class Promotion < ApplicationRecord
  validates :promo_price, comparison: { less_than: :original_price }
  validates :min_quantity, presence: true
  has_many :items
end
