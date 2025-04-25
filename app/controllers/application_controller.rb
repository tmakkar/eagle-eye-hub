class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  helper_method :current_cart

  def current_cart
  session[:cart] ||= {}
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :address, :province ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :address, :province ])
  end

  add_breadcrumb "Home", :root_path
end
