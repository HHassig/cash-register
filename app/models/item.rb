class Item < ApplicationRecord
  validates :inventory_remaining, :numericality => { :greater_than_or_equal_to => 0 }
  has_many :promotions
end
