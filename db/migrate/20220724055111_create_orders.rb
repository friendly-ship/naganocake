class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
    t.integer :customer_id
    t.string :address
    t.string :shipping_name
    t.string :postal_code
    t.integer :shipping_cost
    t.integer :total_payment
    t.integer :payment_method
    t.integer :status
    t.string :name
    
    
    t.timestamps
    end
  end
end
