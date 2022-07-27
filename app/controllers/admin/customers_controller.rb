class Admin::CustomersController < ApplicationController
 before_action :authenticate_admin!

  # 会員一覧画面
  def index
  	@customers = customer.page(params[:page]).per(10)
  end

  # 会員情報編集画面
  def edit
  	@customer = customer.find(params[:id])
  end

  def update
  	@customer = customer.find(params[:id])
  	if @customer.update(customer_params)
  		redirect_to admin_customer_path(@customer)
  	else
  		render "edit"
  	end
  end

  def show
     @customer = customer.find(params[:id])
  end

  private

  def customer_params
  	params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :postal_code,:address, :phone_number, :withdrawal_status)
  end
end