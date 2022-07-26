class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_items
  has_many :addresses
  has_many :orders
  
  enum withdrawal_status: { 有効: 0, 無効: 1 }

  #validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, presence: true

end

