class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
 before_action :require_admin
# GET /products or /products.json

add_breadcrumb "Products", :products_path

def show
  @product = Product.find(params[:id])
  add_breadcrumb @product.category.name, category_path(@product.category)
  add_breadcrumb @product.name, product_path(@product)
end
  def index
    @products = Product.all

    # Search logic
    if params[:search].present?
      keyword = params[:search]
      @products = @products.where("name ILIKE ? OR description ILIKE ?", "%#{keyword}%", "%#{keyword}%")
    end

    # Category filter
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Filter logic as before...
    @products = @products.page(params[:page]).per(6)
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    @category = @product.category
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_to_cart
    # logic to add product to cart
    flash[:notice] = "Product added to cart!"
    redirect_to cart_path
  end


  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!


  flash[:alert] = "Product was deleted!"
  redirect_to products_path

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :description, :price, :stock_quantity, :image_url ])
    end
end
private

def require_admin
  redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
end
private

def product_params
  params.require(:product).permit(:name, :description, :price, :image, :category_id)
end
def index
  @products = Product.all
  # Filtering
  @products = @products.where(on_sale: true) if params[:filter] == "on_sale"
  @products = @products.order(created_at: :desc) if params[:filter] == "new"
  @products = @products.order(updated_at: :desc) if params[:filter] == "updated"

  @products = @products.page(params[:page]).per(6) # show 6 per page
end
