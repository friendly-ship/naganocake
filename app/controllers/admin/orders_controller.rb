class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @path = Rails.application.routes.recognize_path(request.referer)
    if @path[:controller] == "admin/customers" && @path[:action] == "show"
       @order = Order.where(customer_id: params[:format]).page(params[:page]).per(7)
    elsif @path[:controller] == "admin/admins"
       @order = Order.where(created_at: Time.zone.today.all_day).page(params[:page]).per(7)
    else
       @order = Order.page(params[:page]).per(7)
  end
  end

  def show
  	# 注文内容の情報を取得しています！
  	@order = Order.find(params[:id])
    # 注文内容の商品を取得しています！
  	@order_items = @order.order_items
  end

  def update
  	@order = Order.find(params[:id]) #注文詳細の特定
  	@order_items = @order.order_items #注文から紐付く商品の取得
  	@order.update(order_params) #注文ステータスの更新

 
 	if @order.order_status == "入金確認" #注文ステータスが入金確認なら下の事をする
	     @order_items.update_all(making_status: 1) #製作ステータスを「製作待ちに」　更新
	     end
  		 redirect_to  admin_order_path(@order) #注文詳細に遷移
    end
    # こっちでも可能
    # emunの変換前取得している
  	# if @order.read_attribute_before_type_cast(:order_status) == 1
  	# 	@order_items.each do |order_item|
  	# 	order_item.update(making_status: 1)
  	# 	end
   #  end


  private

  def order_params
  	params.require(:order).permit(:order_status)
  end

end