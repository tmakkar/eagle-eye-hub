class Product < ApplicationRecord
  has_one_attached :image
  has_and_belongs_to_many :categories
  validates :name, :price, :stock_quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :category
end
