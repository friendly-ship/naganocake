class Item < ApplicationRecord
  
	has_many :cart_items
	has_many :order_items
	belongs_to :genre

  # 画像のためのやつ
	attachment :image

  # enumの設定
	enum sale_status: {販売中:0,販売停止:1}

  # バリデーション
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
end