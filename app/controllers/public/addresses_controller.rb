class Public::AddressesController < ApplicationController
	before_action :authenticate_customer!
  def index
  	@addresses = current_customer.addresses.page(params[:page]).per(3) # ページネーションの追加/3件ごとにページ作成
  	@address = Address.new
  end

  def create
  	@address = Address.new(address_params)
  	@address.customer_id = current_customer.id
  	@address.save
  	redirect_to public_addresses_path
  end

  def edit
  	@address = Address.find(params[:id])
  end

  def update
  	@address = Address.find(params[:id])
  	@address.update(address_params)
  	redirect_to public_addresses_path
  end

  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to public_addresses_path
  end

  private
  def address_params
  	params.require(:address).permit(:name, :customer_id, :shipping_address, :postal_code)
  end
end