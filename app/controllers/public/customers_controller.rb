class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!
  def show
  	@customer = current_customer
  end

  def edit
  	@customer = current_customer
  end

  def update
  	@customer = current_customer
  	@customer.update(customer_params)
  	redirect_to public_customers_path
  end

  def withdrawal
  end

  
  def destroy
    current_customer.update(is_deleted: true, withdrawal_status: 1)
    reset_session
    redirect_to root_path
  end
  
 private
  def customer_params
   	params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :withdrawal_status, :email)
  end
end
