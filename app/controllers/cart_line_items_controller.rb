class CartLineItemsController < ApplicationController
  before_action :set_line_item, only: [:update, :destroy]

  def update
    if @line_item.update(quantity: params[:cart_line_item][:quantity])
      redirect_to cart_path(@line_item.cart), notice: "Quantity updated."
    else
      redirect_to cart_path(@line_item.cart), alert: "Update failed."
    end
  end

  def destroy
    @line_item.destroy
    redirect_to cart_path(@line_item.cart), notice: "Item removed."
  end

  private

  def set_line_item
    @line_item = CartLineItem.find(params[:id])
  end
end
