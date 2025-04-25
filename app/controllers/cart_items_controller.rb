class CartItemsController < ApplicationController
  def create
    session[:cart] ||= {}
    product_id = params[:product_id].to_s
    session[:cart][product_id] = (session[:cart][product_id] || 0).to_i + params[:quantity].to_i
    redirect_to cart_path
  end

  def update
    product_id = params[:product_id].to_s
    session[:cart][product_id] = params[:quantity].to_i
    redirect_to cart_path
  end

  def destroy
    session[:cart].delete(params[:product_id].to_s)
    redirect_to cart_path
  end
end
