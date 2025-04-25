class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    order = current_user.orders.create!(
      status: 'pending',
      total_price: 0
    )

    total = 0
    current_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      price = product.price
      order.order_items.create!(
        product:,
        quantity:,
        price_at_time_of_order: price
      )
      total += price * quantity.to_i
    end

    order.update!(total_price: total)
    session[:cart] = {}

    redirect_to order_path(order), notice: "Order placed!"
  end

  def index
    @orders = current_user.orders.includes(:order_items)
  end
  
  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to admin_orders_path
  end
  
end
