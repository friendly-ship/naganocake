class CartItem < ApplicationRecord
  belongs_to :customer
	belongs_to :item

  validates :number_of_items, presence: true

	# def total
	# 	self.cart_item.item.unit_price_without_tax * self.cart_item.number_of_items
	# end
end