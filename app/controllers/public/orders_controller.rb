class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!
  before_action :request_post?, only: [:confirm]
  before_action :order_new?, only: [:new]

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_item = @order.order_items 
    @total = 0 
  end

  def new
    @customer = current_customer
    @i = current_customer.cart_items
    @all = Item.all
    @i.each do |item|
      @all = @all.where.not(id: item.item_id)
    end
    @item_random = @all.order("RANDOM()").limit(2)

    @order = Order.new
    @address = Address.new
  end

  def confirm
    params[:order][:payment_method] = params[:order][:payment_method].to_i 
    @order = Order.new(order_params) 

    if params[:order][:address_number] == "1" 
      @order.postal_code = current_customer.postal_code 
      @order.address = current_customer.address 
      @order.name = current_customer.last_name+current_customer.first_name 

    elsif  params[:order][:address_number] ==  "2" 
      @order.postal_code = Address.find(params[:order][:address]).postal_code 
      @order.address = Address.find(params[:order][:address]).shipping_address 
      @order.name = Address.find(params[:order][:address]).name 
    elsif params[:order][:address_number] ==  "3" 
      @address = Address.new() 
      @address.shipping_address = params[:order][:shipping_address] 
      @address.name = params[:order][:name] 
      @address.postal_code = params[:order][:postal_code]
      @address.customer_id = current_customer.id 
      if @address.save 
      @order.postal_code = @address.postal_code 
      @order.name = @address.name 
      @order.address = @address.shipping_address 
      else
       render 'new'
       end
  end

    @cart_items = CartItem.where(customer_id: current_customer.id) 
    @total = 0 
  end


  def thanks
    
  end

  def create
    @order = Order.new(order_params) 
    @order.customer_id = current_customer.id 
    @order.save 

current_customer.cart_items.each do |cart_item| 
  @order_item = OrderItem.new 
  @order_item.item_id = cart_item.item_id 
  @order_item.number_of_items = cart_item.number_of_items
  @order_item.items_tax_included_price = (cart_item.item.unit_price_without_tax*1.1).floor 
  @order_item.order_id =  @order.id 
  @order_item.save 
end 

    current_customer.cart_items.destroy_all 
    redirect_to public_orders_thanks_path 

end

  private

  def order_new?
    redirect_to public_cart_items_path, notice: "カートに商品を入れてください。" if current_customer.cart_items.blank?
  end

  def request_post?
    redirect_to new_public_order_path, notice: "もう一度最初から入力してください。" unless request.post?
  end

  def order_params
    params.require(:order).permit(:payment_method, :address, :postage, :postal_code, :name, :total_fee, :addre)
  end

  def address_params
    params.permit(:shipping_address, :name, :postal_code, :customer_id)
  end

end