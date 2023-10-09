class Promotion < ApplicationRecord
  validates :min_quantity, presence: true
  has_many :items
end
