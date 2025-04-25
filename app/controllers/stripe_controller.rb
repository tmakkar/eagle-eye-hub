class StripeController < ApplicationController
  def checkout
    order = current_user.orders.find(params[:order_id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: order.order_items.map do |item|
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: item.product.name
            },
            unit_amount: (item.price * 100).to_i
          },
          quantity: item.quantity
        }
      end,
      mode: 'payment',
      success_url: root_url + '?success=true',
      cancel_url: root_url + '?canceled=true'
    )

    redirect_to session.url, allow_other_host: true
  end
end
