class CartsController < ApplicationController
  def show
    @cart_items = current_cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      { product:, quantity: quantity.to_i } if product
    end.compact
  end


  def add_to_cart
    product = Product.find(params[:id])
    session[:cart] ||= {}
    session[:cart][product.id.to_s] ||= 0
    session[:cart][product.id.to_s] += 1

    session[:cart_count] ||= 0
    session[:cart_count] += 1

    flash[:notice] = "#{product.name} added to cart! (#{session[:cart_count]} total)"
    redirect_to cart_path
  end

  private

def current_cart
  session[:cart] ||= {}
end
end
